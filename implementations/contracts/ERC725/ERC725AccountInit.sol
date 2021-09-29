// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.0;

// modules
import "./ERC725Init.sol";
import "./ERC725AccountCore.sol";

/**
 * @title ERC725Account
 * @dev Bundles ERC725X and ERC725Y, and ERC1271 and allows receiving native tokens.
 *
 *  @author Fabian Vogelsteller <fabian@lukso.network>
 */

contract ERC725AccountInit is ERC725Init, ERC725AccountCore  {

    function initialize(address _newOwner) virtual override(ERC725Init) public initializer {
        ERC725Init.initialize(_newOwner);

        _registerInterface(_INTERFACE_ID_ERC725Account);
        _registerInterface(_INTERFACE_ID_ERC1271);
        _registerInterface(_INTERFACE_ID_LSP1);
    }

        function execute(
        uint256 _operation,
        address _to,
        uint256 _value,
        bytes calldata _data
    ) public payable virtual override(ERC725XInit,ERC725XCore) onlyOwner returns(bytes memory result) {
        result = ERC725XInit.execute(_operation,_to,_value,_data);
    }

        function setData(bytes32[] memory _keys, bytes[] memory _values)
        public
        virtual override(ERC725YInit,ERC725YCore) onlyOwner {
         ERC725YInit.setData(_keys, _values);
    }
}
