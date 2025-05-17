// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;
    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 10e18;
    uint256 constant STARTING_BALANCE = 100 ether;
    uint256 constant GAS_PRICE = 1;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMinimumUSDIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testi_ownerIsMsgSender() public view {
        assertEq(fundMe.getOwner(), msg.sender);
    }

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: SEND_VALUE}();
        _;
    }

    function testFundUpdatesFundedDataStructure() public funded {
        uint256 AmountFunded = fundMe.getaddresstoAmountFunded(USER);
        assertEq(AmountFunded, SEND_VALUE);
    }

    function testAddsFundertoArrayofFunders() public funded {
        address funder = fundMe.getfunders(0);
        assertEq(funder, USER);
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        vm.prank(USER);
        fundMe.withdraw();
    }

    function testWithdrawWithASingleFunder() public funded {
        // Arrange
        uint256 StartingOwnerBalance = fundMe.getOwner().balance;
        uint256 StartingFundMeBalance = address(fundMe).balance;

        // Act
        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        // Assert
        uint256 EndingOwnerBalance = fundMe.getOwner().balance;
        uint256 EndingFundMeBalance = address(fundMe).balance;
        assertEq(EndingFundMeBalance, 0); // balance of contract should be 0
        assertEq(StartingOwnerBalance + StartingFundMeBalance, EndingOwnerBalance); // owner balance should be equal to starting balance + starting fundme balance)
    }

    function testWithdrawFromMultipleFunders() public funded {
        // Arrange
        uint160 NumberofFunders = 10;
        uint160 StartingFunderIndex = 1;

        for (uint160 i = StartingFunderIndex; i < NumberofFunders; i++) {
            // vm.prank (USER) new addresses
            // vm.deal(USER, SEND_VALUE) newaddresses instead we use hoax;
            hoax(address(i), STARTING_BALANCE);
            fundMe.fund{value: SEND_VALUE}();
        }
        uint256 StartingOwnerBalance = fundMe.getOwner().balance;
        uint256 StartingFundMeBalance = address(fundMe).balance;

        // Act
        // uint256 gasStart = gasleft();
        vm.txGasPrice(GAS_PRICE);
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();
        // uint256 gasEnd = gasleft();
        // uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        // console.log(gasUsed);
        // This gas function is used for checking how much gas was used overall in the vm address
        // Assert

        uint256 EndingOwnerBalance = fundMe.getOwner().balance;
        uint256 EndingFundMeBalance = address(fundMe).balance;
        assertEq(EndingFundMeBalance, 0); // balance of contract should be 0
        assertEq(StartingOwnerBalance + StartingFundMeBalance, EndingOwnerBalance); // owner balance should be equal to starting balance + starting fundme balance)
    }

    function testWithdrawFromMultipleFunderscheaper() public funded {
        // Arrange
        uint160 NumberofFunders = 10;
        uint160 StartingFunderIndex = 1;

        for (uint160 i = StartingFunderIndex; i < NumberofFunders; i++) {
            // vm.prank (USER) new addresses
            // vm.deal(USER, SEND_VALUE) newaddresses instead we use hoax;
            hoax(address(i), SEND_VALUE);
            fundMe.fund{value: SEND_VALUE}();
        }
        uint256 StartingOwnerBalance = fundMe.getOwner().balance;
        uint256 StartingFundMeBalance = address(fundMe).balance;

        // Act
        // uint256 gasStart = gasleft();
        vm.txGasPrice(GAS_PRICE);
        vm.startPrank(fundMe.getOwner());
        fundMe.cheaperwithdraw();
        vm.stopPrank();
        // uint256 gasEnd = gasleft();
        // uint256 gasUsed = (gasStart - gasEnd) * tx.gasprice;
        // console.log(gasUsed);
        // This gas function is used for checking how much gas was used overall in the vm address
        // Assert

        assertEq(address(fundMe).balance, 0); // balance of contract should be 0
        assertEq(StartingOwnerBalance + StartingFundMeBalance, fundMe.getOwner().balance); // owner balance should be equal to starting balance + starting fundme balance)
    }
}
