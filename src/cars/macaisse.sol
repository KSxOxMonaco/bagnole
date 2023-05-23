pragma solidity 0.8.17;

import "./../interfaces/ICar.sol";

contract macaisse is ICar {
    function takeYourTurn(
        Monaco monaco,
        Monaco.CarData[] calldata allCars,
        uint256[] calldata bananas,
        uint256 ourCarIndex
    ) external override {

        Monaco.CarData memory maGrosseKaisse = allCars[ourCarIndex];
        uint256 turnsToWin = maGrosseKaisse.speed == 0 ? 1000 : (1000 - maGrosseKaisse.y) / maGrosseKaisse.speed;
        
        // regarde si on peut en achetant le max de vitesse
        uint256 accelToWin = (1000 - maGrosseKaisse.y) - maGrosseKaisse.speed;
        if (maxAccel(monaco, maGrosseKaisse.balance) >= accelToWin) {
            accelerate(monaco, maGrosseKaisse, accelToWin);
            stopOpponent(monaco, allCars, maGrosseKaisse, ourCarIndex, maGrosseKaisse, 100000);
            accelerate(monaco, maGrosseKaisse, maxAccel(monaco, maGrosseKaisse.balance));
            return;
        }

        //regarder si une bagnole méchante gagne au prochain tour
        
        // on gagne au prochain tour
        if(turnsToWin == 1){
            
        }

        // regarder on l'on est et ou sont les autres
        // regarder si l'on peut gagner des maintenant

        // regarder l'état du marché
        // regarder l'état du portefeuille

        //traite les datas 
        //prise d'iniative 


        

    
    
    
    }

    function buyBanane() internal{}

    function buyShell()internal{}

    function buySuperShell()internal{}

    function buyShield()internal{}

    function buyAcceleration()internal{}

    function vrOUM()internal{}

function sayMyName() external pure returns (string memory) {
        return "HENRIIIIIIIIII";
    }

}