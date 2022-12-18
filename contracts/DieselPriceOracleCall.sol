pragma solidity ^0.8.7;

import "https://github.com/provable-things/ethereum-api/blob/master/contracts/solc-v0.8.x/provableAPI.sol";

// Provable example: https://docs.provable.xyz/docs/solidity-by-example
contract DieselPriceOracleCall is usingProvable { // wont work yet until FEVM is updated to do cross contract calls

    uint public dieselPriceUSD;

    event LogNewDieselPrice(string price);
    event LogNewProvableQuery(string description);

    constructor(uint some) public
    {
        update(); // First check at contract creation...
    }

    function __callback(
        bytes32 _myid,
        string memory _result
    )
        public
    {
        require(msg.sender == provable_cbAddress());
        emit LogNewDieselPrice(_result);
        dieselPriceUSD = parseInt(_result, 2); // Let's save it as cents...
        // Now do something with the USD Diesel price...
    }

    function update()
        public
        payable
    {
        emit LogNewProvableQuery("Provable query was sent, standing by for the answer...");
        provable_query("URL", "xml(https://www.fueleconomy.gov/ws/rest/fuelprices).fuelPrices.diesel");
    }
}