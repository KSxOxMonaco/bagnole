// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./../interfaces/ICar.sol";

contract banane is ICar{

    uint8 constant FLOOR = 10;

    function takeYourTurn(
        Monaco monaco,
        Monaco.CarData[] calldata allCars,
        uint256[] calldata bananas,
        uint256 ourCarIndex
    ) external override {

         Monaco.CarData memory ourCar = allCars[ourCarIndex];
        // buy if cheap
        /*if (monaco.getShellCost(1) < FLOOR) {
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
        }*/

        monaco.buyBanana();
    }

    function sayMyName() external pure returns (string memory) {
        return "banane";
    }
}