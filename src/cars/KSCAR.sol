// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./../interfaces/ICar.sol";

contract KSCAR is ICar{

    uint8 constant FLOOR = 10;
    uint16 turn = 1; 
    function takeYourTurn(
        Monaco monaco,
        Monaco.CarData[] calldata allCars,
        uint256[] calldata bananas,
        uint256 ourCarIndex
    ) external override {


         Monaco.CarData memory ourCar = allCars[ourCarIndex];

         uint256 accelToWin = (1000 - ourCar.y) - ourCar.speed;
         if(accelToWin <= maxAccel(monaco, ourCar.balance)){
            monaco.accelerate(accelToWin);
         }/*
         else{
             monaco.accelerate(maxAccel(monaco, ourCar.balance));
         }*/

        // buy if cheap
        if (monaco.getShellCost(1) < FLOOR) {
            monaco.buyShell(2);
        }
        if (monaco.getSuperShellCost(1) < FLOOR) {
            monaco.buySuperShell(2);
        }
        if (monaco.getShieldCost(1) < FLOOR) {
            monaco.buyShield(2);
        }
        if (monaco.getBananaCost() < FLOOR) {
            monaco.buyBanana();
        }

        if(ourCar.y == 0){
            monaco.buyAcceleration(4);
            monaco.buyShield(1); 
        }

        if(turn % 2 == 0){
            monaco.buyBanana();
        }
        if(turn % 2 == 1){
            monaco.buyAcceleration(maxAccel(monaco, ourCar.balance)/3);
            monaco.buyShield(1);
        }

        if(turn % 3 == 0){
            monaco.buyShell(1);
        }
        
        }

    

    function maxAccel(Monaco monaco, uint256 balance) internal view returns (uint256 amount) {
        uint256 current = 25;
        uint256 min = 0;
        uint256 max = 50;
        while (max - min > 1) {
            uint256 cost = monaco.getAccelerateCost(current);
            if (cost > balance) {
                max = current;
            } else if (cost < balance) {
                min = current;
            } else {
                return current;
            }
            current = (max + min) / 2;
        }
        return min;
    }

    function checkIfWin() internal returns (bool) {
        for(uint i; i < 3; i++){
            if(monaco.getCarData(i).y == 0){
                return true;
            }
        }
    }

    function sayMyName() external pure returns (string memory) {
        return "KSCAR";
    }
}