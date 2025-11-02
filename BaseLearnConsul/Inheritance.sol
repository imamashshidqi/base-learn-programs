// READ THIS FIRST!!!

/**
 * 1. First go to https://remix.ethereum.org/
 * 2. Add this script then run script
 * 3. After run script go to Deploy & run transactions on left navbar
 * 4. at Environtment chose ConnectWallet then your account. makesure connect with base sepolia testnet network

    NOTE: Here, after COMPILE in the Deploy & run transactions section, there is a CONTRACT TAB that you must select:
    
    🔧 1. Salesperson contract in Remix, then fill in the constructor with:
    hourlyRate  → 20
    idNumber    → 55555
    managerId   → 12345
    click Deploy → copy Contract Address of Salesperson.

    🔧 2. Deploy EngineeringManager
    Select the EngineeringManager contract, fill in the constructor with:
    annualSalary    → 200000
    idNumber        → 54321
    managerId       → 11111
    click Deploy → copy Contract Address of Salesperson.

    After saving the 2 contracts, only then choose Contract InheritanceSubmission-InheritanceExercise.sol.
    REMEMBER before deploying, you need to input the 2 contracts you saved earlier.  

    Only after that, deploy, and copy and paste the deployed contract into the docs.

 * 5. go to https://docs.base.org/learn/inheritance/inheritance-exercise -> Submit Contract Address.
 */


// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

/**
 * @title Employee
 * @dev Abstract contract defining common properties and behavior for employees.
 */
abstract contract Employee {
    uint public idNumber; // Unique identifier for the employee
    uint public managerId; // Identifier of the manager overseeing the employee

    /**
     * @dev Constructor to initialize idNumber and managerId.
     * @param _idNumber The unique identifier for the employee.
     * @param _managerId The identifier of the manager overseeing the employee.
     */
    constructor(uint _idNumber, uint _managerId) {
        idNumber = _idNumber;
        managerId = _managerId;
    }

    /**
     * @dev Abstract function to be implemented by derived contracts to get the annual cost of the employee.
     * @return The annual cost of the employee.
     */
    function getAnnualCost() public virtual returns (uint);
}

/**
 * @title Salaried
 * @dev Contract representing employees who are paid an annual salary.
 */
contract Salaried is Employee {
    uint public annualSalary; // The annual salary of the employee

    /**
     * @dev Constructor to initialize the Salaried contract.
     * @param _idNumber The unique identifier for the employee.
     * @param _managerId The identifier of the manager overseeing the employee.
     * @param _annualSalary The annual salary of the employee.
     */
    constructor(uint _idNumber, uint _managerId, uint _annualSalary) Employee(_idNumber, _managerId) {
        annualSalary = _annualSalary;
    }

    /**
     * @dev Overrides the getAnnualCost function to return the annual salary of the employee.
     * @return The annual salary of the employee.
     */
    function getAnnualCost() public override view returns (uint) {
        return annualSalary;
    }
}

/**
 * @title Hourly
 * @dev Contract representing employees who are paid an hourly rate.
 */
contract Hourly is Employee {
    uint public hourlyRate; // The hourly rate of the employee

    /**
     * @dev Constructor to initialize the Hourly contract.
     * @param _idNumber The unique identifier for the employee.
     * @param _managerId The identifier of the manager overseeing the employee.
     * @param _hourlyRate The hourly rate of the employee.
     */
    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) Employee(_idNumber, _managerId) {
        hourlyRate = _hourlyRate;
    }

    /**
     * @dev Overrides the getAnnualCost function to calculate the annual cost based on the hourly rate.
     * Assuming a full-time workload of 2080 hours per year.
     * @return The annual cost of the employee.
     */
    function getAnnualCost() public override view returns (uint) {
        return hourlyRate * 2080;
    }
}

/**
 * @title Manager
 * @dev Contract managing a list of employee IDs.
 */
contract Manager {
    uint[] public employeeIds; // List of employee IDs

    /**
     * @dev Function to add a new employee ID to the list.
     * @param _reportId The ID of the employee to be added.
     */
    function addReport(uint _reportId) public {
        employeeIds.push(_reportId);
    }

    /**
     * @dev Function to reset the list of employee IDs.
     */
    function resetReports() public {
        delete employeeIds;
    }
}

/**
 * @title Salesperson
 * @dev Contract representing salespeople who are paid hourly.
 */
contract Salesperson is Hourly {
    /**
     * @dev Constructor to initialize the Salesperson contract.
     * @param _idNumber The unique identifier for the employee.
     * @param _managerId The identifier of the manager overseeing the employee.
     * @param _hourlyRate The hourly rate of the employee.
     */
    constructor(uint _idNumber, uint _managerId, uint _hourlyRate) 
        Hourly(_idNumber, _managerId, _hourlyRate) {}
}

/**
 * @title EngineeringManager
 * @dev Contract representing engineering managers who are paid an annual salary and have managerial responsibilities.
 */
contract EngineeringManager is Salaried, Manager {
    /**
     * @dev Constructor to initialize the EngineeringManager contract.
     * @param _idNumber The unique identifier for the employee.
     * @param _managerId The identifier of the manager overseeing the employee.
     * @param _annualSalary The annual salary of the employee.
     */
    constructor(uint _idNumber, uint _managerId, uint _annualSalary) 
        Salaried(_idNumber, _managerId, _annualSalary) {}
}

/**
 * @title InheritanceSubmission
 * @dev Contract for deploying instances of Salesperson and EngineeringManager.
 */
contract InheritanceSubmission {
    address public salesPerson; // Address of the deployed Salesperson instance
    address public engineeringManager; // Address of the deployed EngineeringManager instance

    /**
     * @dev Constructor to initialize the InheritanceSubmission contract.
     * @param _salesPerson Address of the deployed Salesperson instance.
     * @param _engineeringManager Address of the deployed EngineeringManager instance.
     */
    constructor(address _salesPerson, address _engineeringManager) {
        salesPerson = _salesPerson;
        engineeringManager = _engineeringManager;
    }
}