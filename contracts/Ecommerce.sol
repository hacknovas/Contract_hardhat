// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >=0.7.0 <0.9.0;

contract Ecommerce {
    struct ProductD {
        uint id;
        string name;
        uint price;
        string desc;
        address seller;
        address buyer;
        bool isBuy;
    }

    address payable owner_E; //owner of contract(eccommerce)
    uint public total_p = 0;
    event product_listed_S(address seller, uint proId);
    event product_owner_changed(
        address oldOwner,
        address newOwner,
        uint prodId
    );

    mapping(address => ProductD[]) user_Products; //hold all product belong to user
    mapping(uint => ProductD) single_Product; //hold Single product data

    constructor() {
        owner_E = payable(msg.sender);
    }

    // register product
    function list_Product(
        string memory _name,
        string memory _desc,
        uint _price
    ) public {
        ProductD memory ne = ProductD({
            id: total_p,
            name: _name,
            price: _price,
            desc: _desc,
            seller: msg.sender,
            buyer: msg.sender,
            isBuy: false
        });

        single_Product[total_p] = ne;

        emit product_listed_S(msg.sender, total_p);
        total_p++;
    }

    // get details of single product
    function getSingle_Product(uint _id) public view returns (ProductD memory) {
        return single_Product[_id];
    }

    // buy product
    function buy_Product(uint _id) public payable {
        require(msg.value == single_Product[_id].price, "Enter Perfect Amount");
        require(
            msg.sender != single_Product[_id].seller,
            "Owner can't buy the product"
        );

        single_Product[_id].buyer = msg.sender;
        single_Product[_id].isBuy = true;

        user_Products[msg.sender].push(single_Product[_id]);
    }
}
