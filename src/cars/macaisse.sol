pragma solidity 0.8.17;

import "./../interfaces/ICar.sol";

contract macaisse is ICar {
    uint8 constant treshold = 8; 
    function takeYourTurn(
        Monaco monaco,
        Monaco.CarData[] calldata allCars,
        uint256[] calldata bananas,
        uint256 ourCarIndex
    ) external override {

        uint256 superShellPrice = monaco.getSuperShellCost(1); 
        uint256 shellPrice = monaco.getShellCost(1); 
        uint256 shieldPrice = monaco.getShieldCost(1); 
        uint256 bananaPrice = monaco.getBananaCost(1); 
        uint256 accelPrice = monaco.getAccelerateCost(1); 


        Monaco.CarData memory ourCar = allCars[ourCarIndex];
        uint256 turnsToWin = ourCar.speed == 0
            ? 1000
            : (1000 - ourCar.y) / ourCar.speed;

        // regarde si on peut en achetant le max de vitesse
        uint256 accelToWin = (1000 - ourCar.y) - ourCar.speed;
        if (maxAccel(monaco, ourCar.balance) >= accelToWin) {
            accelerate(monaco, ourCar, accelToWin);
            stopOpponent(monaco, allCars, ourCar, ourCarIndex, ourCar, 100000);
            accelerate(monaco, ourCar, maxAccel(monaco, ourCar.balance));
            return;
        }

        

        // on gagne au prochain tour donc on se protège
        // TODO tester si une supershell achete en premier nous baise
        if (turnsToWin == 1) {
            monaco.buyShield(1); 
            monaco.buyBanana(); 
        }

        // regarder on l'on est et ou sont les autres
        (uint turnLoose, uint bestOppenent) = getTurnsToLose(
            monaco,
            allCars,
            ourCarIndex
        );

        //condition en fonction de la place des autres 
        if (turnLoose <= 1) {
            nuke(bestOppenent);
        } else if (turnLoose < 4) {
            tryStop(bestOppenent, 5);
        } else if (turnLoose < 8) {
            tryStop(bestOppenent, 2);
        }

        // regarder l'état du marché
        if(accelPrice < treshold){
            monaco.buyAcceleration(1); 
        }
        if(superShellPrice < treshold){
            monaco.buySuperShell(1); 
        }
        if(shellPrice < treshold){
            monaco.buyShell(1); 
        }
        if(shieldPrice < treshold){
            monaco.buyShield(1); 
        }
        if(bananaPrice < treshold){
            monaco.buyBanana(); 
        }
        // regarder l'état du portefeuille

        //traite les datas
        //prise d'iniative
    }

    function getTurnsToLose(
        Monaco monaco,
        Monaco.CarData[] calldata allCars,
        uint256 ourCarIndex
    ) internal returns (uint256 turnsToLose, uint256 bestOpponentIdx) {
        turnsToLose = 1000;
        for (uint256 i = 0; i < allCars.length; i++) {
            if (i != ourCarIndex) {
                Monaco.CarData memory car = allCars[i];
                uint256 maxSpeed = car.speed + maxAccel(monaco, car.balance);
                uint256 turns = maxSpeed == 0
                    ? 1000
                    : (1000 - car.y) / maxSpeed;
                if (turns < turnsToLose) {
                    turnsToLose = turns;
                    bestOpponentIdx = i;
                }
            }
        }
    }

  
    function nuke(uint256 bestOpponentId) internal {
        //TODO optimize by looking at banana, shield and positions
     
     uint256 1sCost = monaco.getShellCost(1); 
     uint256 2sCost = monaco.getShellCost(2); 
     if(ourCar.balance >= superShellPrice){
        monaco.buySuperShell(1); 
     }else if(ourCar.balance >= 2sCost)
        monaco.buyShell(2); 
    }else if(ourCar.balance >= 1sCost){
        monaco.buyShell(1); 
    }

    function tryStop(uint256 bestOpponentId, uint256 pourcentage) internal {
        // chekc if our opponent is more than 1 car away
        Monaco.CarData memory bestCar = allCars[bestOpponentId];
        uint256 shellPrice = monaco.getShellCost(1); 
        uint256 ssPrice = monaco.getSuperShellCost(1); 
        if(bestCar.shield >=1){
            if(ssPrice <= ourCar.balance*(pourcentage/100)){
                monaco.buySuperShell(1); 
            }
            //look to buy a supershell
        }else if(shellPrice <= ourCar.balance *(pourcentage /100)){
            monaco.buyShell(); 
        }
    }

    function sayMyName() external pure returns (string memory) {
        return "HENRIIIIIIIIII";
    }
}
