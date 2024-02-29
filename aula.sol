pragma solidity >= 0.4.22 < 0.6.0; 

import "./strings.sol";

contract myRegister {
    
    address owner; 
    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    struct User {
        string nome;
        string idade;
        string cpf;
        string cargo;
        string endereco;
    }

    event myUser ( 
        string nome,
        string idade,
        string cpf,
        string cargo
    );

    User[] usuarios;

    mapping(string => User) public usuario;
    
    function registerUser(string memory _nome, string memory _idade, string memory _cpf, string memory _cargo, string memory _hash) public onlyOwner{
        User memory user;
        user.nome = _nome;
        user.idade = _idade;
        user.cpf = _cpf;
        user.cargo = _cargo;
        user.endereco = _hash;

        usuario[_hash]=user;

        usuarios.push(user); 
        emit myUser(_nome, _idade, _cpf, _cargo);
    }

    function allUsers() public view returns (uint length){
        return usuarios.length;
    }

    function getUser(string memory _id) public view returns(string memory userObtido){
        string memory a;
        User memory c = usuario[_id];
        bytes memory tempEmptyStringTest = bytes(c.nome);
        if(tempEmptyStringTest.length != 0){
            a = string(string(abi.encodePacked("o nome do usuário é ", c.nome, ",",
                                                                    "de ", c.idade, "anos", ",",
                                                                    "detentor do cpf:", c.cpf, "e desempenha a funçao de ", 
                                                                    c.cargo,".")));
        }else 
            a = string(string(abi.encodePacked("Hash nao encontrada"))); 

        return a;
        }
    
}