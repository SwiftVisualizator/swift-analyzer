var rawNodesData = [
  {
    "name" : "Cat",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct Cat: Pet",
      "modifiers" : [

      ],
      "location" : "Cat.swift:28",
      "inheritance" : [
        "Pet"
      ]
    }
  },
  {
    "name" : "DogOwner",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class DogOwner: Owner, DogOwnerProtocol",
      "modifiers" : [
        "final"
      ],
      "location" : "DogOwner.swift:28",
      "inheritance" : [
        "Owner",
        "DogOwnerProtocol"
      ]
    }
  },
  {
    "name" : "Gender",
    "type" : "enum",
    "metadata" : {
      "declaration" : "enum Gender: String, Equatable, Hashable",
      "modifiers" : [

      ],
      "location" : "Gender.swift:28",
      "inheritance" : [
        "String",
        "Equatable",
        "Hashable"
      ]
    }
  },
  {
    "name" : "CatOwnerProtocol",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "protocol CatOwnerProtocol",
      "modifiers" : [

      ],
      "location" : "CatOwnerProtocol.swift:28",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "App",
    "type" : "root"
  },
  {
    "name" : "DogOwnerProtocol",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "protocol DogOwnerProtocol",
      "modifiers" : [

      ],
      "location" : "DogOwnerProtocol.swift:28",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Application",
    "type" : "struct",
    "metadata" : {
      "declaration" : "@main struct Application: App",
      "modifiers" : [

      ],
      "location" : "Application.swift:30",
      "inheritance" : [
        "App"
      ]
    }
  },
  {
    "name" : "String",
    "type" : "root"
  },
  {
    "name" : "Human",
    "type" : "root"
  },
  {
    "name" : "Dog",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct Dog: Pet",
      "modifiers" : [

      ],
      "location" : "Dog.swift:28",
      "inheritance" : [
        "Pet"
      ]
    }
  },
  {
    "name" : "Hashable",
    "type" : "root"
  },
  {
    "name" : "Owner",
    "type" : "class",
    "metadata" : {
      "declaration" : "class Owner: Human",
      "modifiers" : [

      ],
      "location" : "Owner.swift:28",
      "inheritance" : [
        "Human"
      ]
    }
  },
  {
    "name" : "CatOwnerProtocol",
    "type" : "root"
  },
  {
    "name" : "Animal",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "protocol Animal: Equatable, Hashable",
      "modifiers" : [

      ],
      "location" : "Animal.swift:28",
      "inheritance" : [
        "Equatable",
        "Hashable"
      ]
    }
  },
  {
    "name" : "Human",
    "type" : "class",
    "metadata" : {
      "declaration" : "class Human",
      "modifiers" : [

      ],
      "location" : "Human.swift:28",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "CatOwner",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class CatOwner: Owner, CatOwnerProtocol",
      "modifiers" : [
        "final"
      ],
      "location" : "CatOwner.swift:28",
      "inheritance" : [
        "Owner",
        "CatOwnerProtocol"
      ]
    }
  },
  {
    "name" : "Pet",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "protocol Pet: Animal",
      "modifiers" : [

      ],
      "location" : "Pet.swift:28",
      "inheritance" : [
        "Animal"
      ]
    }
  },
  {
    "name" : "DogOwnerProtocol",
    "type" : "root"
  },
  {
    "name" : "Bear",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct Bear: Animal",
      "modifiers" : [

      ],
      "location" : "Bear.swift:28",
      "inheritance" : [
        "Animal"
      ]
    }
  },
  {
    "name" : "Equatable",
    "type" : "root"
  }
];var rawLinksData = [
  {
    "source" : "CatOwner",
    "target" : "Owner"
  },
  {
    "target" : "CatOwnerProtocol",
    "source" : "CatOwner"
  },
  {
    "target" : "Owner",
    "source" : "DogOwner"
  },
  {
    "target" : "DogOwnerProtocol",
    "source" : "DogOwner"
  },
  {
    "source" : "Owner",
    "target" : "Human"
  },
  {
    "target" : "Pet",
    "source" : "Dog"
  },
  {
    "source" : "Cat",
    "target" : "Pet"
  },
  {
    "target" : "Animal",
    "source" : "Bear"
  },
  {
    "source" : "Application",
    "target" : "App"
  },
  {
    "target" : "String",
    "source" : "Gender"
  },
  {
    "source" : "Gender",
    "target" : "Equatable"
  },
  {
    "target" : "Hashable",
    "source" : "Gender"
  },
  {
    "source" : "Animal",
    "target" : "Equatable"
  },
  {
    "target" : "Hashable",
    "source" : "Animal"
  },
  {
    "source" : "Pet",
    "target" : "Animal"
  }
];