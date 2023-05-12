var rawNodesData = [
  {
    "name" : "MathExpression",
    "type" : "class",
    "metadata" : {
      "declaration" : "public class MathExpression: ComputableExpression, Codable",
      "modifiers" : [
        "public"
      ],
      "location" : "SpecialOctoSystem.swift:77",
      "inheritance" : [
        "ComputableExpression",
        "Codable"
      ]
    }
  },
  {
    "name" : "A",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct A",
      "modifiers" : [

      ],
      "location" : "DeclarationVisitor.swift:17",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Solver",
    "type" : "struct",
    "metadata" : {
      "declaration" : "internal struct Solver",
      "modifiers" : [
        "internal"
      ],
      "location" : "SpecialOctoSystem.swift:147",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Comparable",
    "type" : "root"
  },
  {
    "name" : "UInt8",
    "type" : "root"
  },
  {
    "name" : "AnyObject",
    "type" : "root"
  },
  {
    "name" : "Wrappable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Wrappable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains keyword.",
      "location" : "Wrappable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "AdditionExpression",
    "type" : "class",
    "metadata" : {
      "declaration" : "public class AdditionExpression: MathExpression",
      "modifiers" : [
        "public"
      ],
      "location" : "SpecialOctoSystem.swift:124",
      "inheritance" : [
        "MathExpression"
      ]
    }
  },
  {
    "name" : "DeclarationDependencyMember",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct DeclarationDependencyMember: Hashable",
      "modifiers" : [
        "public"
      ],
      "location" : "DeclarationDependencyMember.swift:12",
      "inheritance" : [
        "Hashable"
      ]
    }
  },
  {
    "name" : "AssociatedTypeDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct AssociatedTypeDeclaration: Declaration, Wrappable, Modifiable, Keywordable, Namable, NestedlyNamable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ An associated type declaration.",
      "location" : "AssociatedTypeDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Wrappable",
        "Modifiable",
        "Keywordable",
        "Namable",
        "NestedlyNamable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "C",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct C: Hashable",
      "modifiers" : [

      ],
      "location" : "DeclarationVisitor.swift:19",
      "inheritance" : [
        "Hashable"
      ]
    }
  },
  {
    "name" : "DependencyError",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum DependencyError: Error",
      "modifiers" : [
        "public"
      ],
      "location" : "DependencyError.swift:12",
      "inheritance" : [
        "Error"
      ]
    }
  },
  {
    "name" : "LoggerProtocol",
    "type" : "root"
  },
  {
    "name" : "FunctionSignature",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct FunctionSignature: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ A function signature.",
      "location" : "FunctionSignature.swift:14",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "LogFormatElement",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum LogFormatElement",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Logger output format element list.",
      "location" : "LogFormatElement.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Encodable",
    "type" : "root"
  },
  {
    "name" : "DirectedEdge",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct DirectedEdge<Content: Hashable>",
      "modifiers" : [

      ],
      "docs" : "\/\/\/ Graph directed edge representation.",
      "location" : "Edge.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "B",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct B",
      "modifiers" : [

      ],
      "location" : "DeclarationVisitor.swift:18",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "MathOperation",
    "type" : "enum",
    "metadata" : {
      "declaration" : "fileprivate enum MathOperation",
      "modifiers" : [
        "fileprivate"
      ],
      "location" : "SpecialOctoSystem.swift:31",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Modifiable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Modifiable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains modifiers.",
      "location" : "Modifiable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "GraphError",
    "type" : "enum",
    "metadata" : {
      "declaration" : "enum GraphError: UInt8, Error",
      "modifiers" : [

      ],
      "location" : "GraphError.swift:12",
      "inheritance" : [
        "UInt8",
        "Error"
      ]
    }
  },
  {
    "name" : "Vertex",
    "type" : "struct",
    "metadata" : {
      "declaration" : "struct Vertex<Content: Hashable>",
      "modifiers" : [

      ],
      "docs" : "\/\/\/ Graph vertex abstraction.",
      "location" : "Vertex.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "MultiplicationExpression",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class MultiplicationExpression: MathExpression",
      "modifiers" : [
        "public",
        "final"
      ],
      "location" : "SpecialOctoSystem.swift:108",
      "inheritance" : [
        "MathExpression"
      ]
    }
  },
  {
    "name" : "ParsedFile",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ParsedFile",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Representation of a parsed file.",
      "location" : "ParsedFile.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "NestedlyNamable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol NestedlyNamable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains name in a full nested manner.\n\/\/\/ For example: `DatabaseManager.MirgrationUtil.Error`.",
      "location" : "NestedlyNamable.swift:14",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "SyntaxVisitor",
    "type" : "root"
  },
  {
    "name" : "LoggerDestinationProtocol",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol LoggerDestinationProtocol",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Interface for logger destination.",
      "location" : "LogDestinationProtocol.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "DefaultLogger",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class DefaultLogger: LoggerProtocol",
      "modifiers" : [
        "public",
        "final"
      ],
      "docs" : "\/\/\/ Standard primitive logger.",
      "location" : "DefaultLogger.swift:13",
      "inheritance" : [
        "LoggerProtocol"
      ]
    }
  },
  {
    "name" : "GenericParameter",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct GenericParameter: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Generic parameter declaration. For example, `Header` and `Body: Codable`\n\/\/\/ from `<Headers, Body: Codable>`.",
      "location" : "GenericParameter.swift:15",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "LoggerDestinationProtocol",
    "type" : "root"
  },
  {
    "name" : "GenericRequirementable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol GenericRequirementable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains information about generic requirements.",
      "location" : "GenericRequirementable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "Accessor",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct Accessor: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "location" : "VariableDeclaration.swift:98",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "StructDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct StructDeclaration: Declaration, Namable, NestedlyNamable, Keywordable, Wrappable, Modifiable, GenericParametable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Struct declaration.",
      "location" : "StructDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "NestedlyNamable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "GenericParametable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "DependencyAnalyzer",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class DependencyAnalyzer",
      "modifiers" : [
        "final"
      ],
      "location" : "DependencyAnalyzer.swift:12",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "PrettyAdditionExpression",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class PrettyAdditionExpression: AdditionExpression",
      "modifiers" : [
        "public",
        "final"
      ],
      "location" : "SpecialOctoSystem.swift:137",
      "inheritance" : [
        "AdditionExpression"
      ]
    }
  },
  {
    "name" : "Stack",
    "type" : "class",
    "metadata" : {
      "docs" : "\/\/\/ Primitive stack model.",
      "declaration" : "final class Stack<Content>",
      "modifiers" : [
        "final"
      ],
      "generics" : [
        "Content"
      ],
      "location" : "Stack.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "ParserError",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum ParserError: Error",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Errors that can be throws during file parsing.",
      "location" : "ParserError.swift:13",
      "inheritance" : [
        "Error"
      ]
    }
  },
  {
    "name" : "LocationMetaHolder",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol LocationMetaHolder: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains meta information about the row location in some file.",
      "location" : "LocationMetaHolder.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "Hashable",
    "type" : "root"
  },
  {
    "name" : "Equatable",
    "type" : "root"
  },
  {
    "name" : "DeclarationVisitor",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class DeclarationVisitor: SyntaxVisitor",
      "modifiers" : [
        "final"
      ],
      "docs" : "\/\/\/ SwiftSyntax visitor subclass that stores visited node models when visiting them.\n\/\/\/ It stores declarations like classes, protocols, extensions etc.",
      "location" : "DeclarationVisitor.swift:15",
      "inheritance" : [
        "SyntaxVisitor"
      ]
    }
  },
  {
    "name" : "GenericParametable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol GenericParametable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains information about generic parameters.",
      "location" : "GenericParametable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "CaseIterable",
    "type" : "root"
  },
  {
    "name" : "Parser",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class Parser: ParserProtocol",
      "modifiers" : [
        "public",
        "final"
      ],
      "docs" : "\/\/\/ Synchronous parser that allows to read files from the filesystem.",
      "location" : "Parser.swift:13",
      "inheritance" : [
        "ParserProtocol"
      ]
    }
  },
  {
    "name" : "CommandLineTool",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class CommandLineTool",
      "modifiers" : [
        "public",
        "final"
      ],
      "location" : "CommandLineTool.swift:33",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "LogFormat",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct LogFormat",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Logger output format.",
      "location" : "LogFormat.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "Wrapper",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct Wrapper: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Helper structure. Wrapper or attribute with extra information about a declaration.\n\/\/\/\n\/\/\/ For example, `@discardableResult`, `@Published`, `@available(*, unavailable)`.",
      "location" : "Wrapper.swift:16",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "Parameter",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct Parameter: Equatable, Hashable, Codable, CustomStringConvertible",
      "modifiers" : [
        "public"
      ],
      "location" : "Wrapper.swift:65",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable",
        "CustomStringConvertible"
      ]
    }
  },
  {
    "name" : "Analyzer",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class Analyzer",
      "modifiers" : [
        "public",
        "final"
      ],
      "location" : "Analyzer.swift:32",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "EnumDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct EnumDeclaration: Declaration, Namable, NestedlyNamable, Keywordable, Wrappable, Modifiable, GenericParametable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Enum declaration.",
      "location" : "EnumDeclarartion.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "NestedlyNamable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "GenericParametable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "CustomStringConvertible",
    "type" : "root"
  },
  {
    "name" : "String",
    "type" : "root"
  },
  {
    "name" : "ProtocolDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ProtocolDeclaration: Declaration, Namable, Keywordable, Wrappable, Modifiable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Protocol declaration.",
      "location" : "ProtocolDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "Metadata",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct Metadata: Encodable",
      "modifiers" : [
        "public"
      ],
      "location" : "ContentGenerator.swift:34",
      "inheritance" : [
        "Encodable"
      ]
    }
  },
  {
    "name" : "CaseDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct CaseDeclaration: Declaration, Wrappable, Modifiable, Keywordable, Namable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ An enumeration case declaration.",
      "location" : "CaseDeclarartion.swift:14",
      "inheritance" : [
        "Declaration",
        "Wrappable",
        "Modifiable",
        "Keywordable",
        "Namable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "ActorDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ActorDeclaration: Declaration, Namable, NestedlyNamable, Keywordable, Wrappable, Modifiable, GenericParametable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Actor declaration.",
      "location" : "ActorDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "NestedlyNamable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "GenericParametable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "SpecialOctoSystemTests",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class SpecialOctoSystemTests: XCTestCase",
      "modifiers" : [
        "final"
      ],
      "location" : "SpecialOctoSystemTests.swift:4",
      "inheritance" : [
        "XCTestCase"
      ]
    }
  },
  {
    "name" : "ProtocolDeclarationTests",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class ProtocolDeclarationTests: XCTestCase",
      "modifiers" : [
        "final"
      ],
      "location" : "ProtocolDeclarationTests.swift:14",
      "inheritance" : [
        "XCTestCase"
      ]
    }
  },
  {
    "name" : "FileMeta",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct FileMeta: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Meta information about the file location.",
      "location" : "FileMeta.swift:13",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "Relation",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum Relation: String, Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Relation operator in the generic requirement.",
      "location" : "GenericRequirement.swift:62",
      "inheritance" : [
        "String",
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "ParserProtocol",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol ParserProtocol",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Interface for working with file parsing.",
      "location" : "ParserProtocol.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "ExtensionDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ExtensionDeclaration: Declaration, Wrappable, Modifiable, Keywordable, Namable, NestedlyNamable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ An extension declaration.",
      "location" : "ExtensionDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Wrappable",
        "Modifiable",
        "Keywordable",
        "Namable",
        "NestedlyNamable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "StructDeclarationTests",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class StructDeclarationTests: XCTestCase",
      "modifiers" : [
        "final"
      ],
      "location" : "StructDeclarationTests.swift:14",
      "inheritance" : [
        "XCTestCase"
      ]
    }
  },
  {
    "name" : "Modifier",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct Modifier: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration modifier. For example, `private(set)`, `open`, `nonmutating`, `static`.",
      "location" : "Modifier.swift:14",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "ImportDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ImportDeclaration: Declaration, Keywordable, Wrappable, Modifiable, Namable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ An import declaration.",
      "location" : "ImportDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "Namable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "DocStringMeta",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct DocStringMeta: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Meta information about a declaration docstring.",
      "location" : "DocStringMeta.swift:14",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "LogLevel",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum LogLevel: UInt8, Comparable, Hashable, CaseIterable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Log levels ordered according to their prioriry.\n\/\/\/\n\/\/\/ The order is *verbose -> info -> debug -> warning -> error -> severe*.",
      "location" : "LogLevel.swift:15",
      "inheritance" : [
        "UInt8",
        "Comparable",
        "Hashable",
        "CaseIterable"
      ]
    }
  },
  {
    "name" : "ClassDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct ClassDeclaration: Declaration, Namable, NestedlyNamable, Keywordable, Wrappable, Modifiable, GenericParametable, Inheritable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Class declaration.",
      "location" : "ClassDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "NestedlyNamable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "GenericParametable",
        "Inheritable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "FileMetaHolder",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol FileMetaHolder: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains meta information about its source file.",
      "location" : "FileMetaHolder.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "TypealiasDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct TypealiasDeclaration: Declaration, Wrappable, Keywordable, Namable, GenericParametable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "location" : "TypealiasDeclaration.swift:13",
      "inheritance" : [
        "Declaration",
        "Wrappable",
        "Keywordable",
        "Namable",
        "GenericParametable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "FunctionParameter",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct FunctionParameter: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Function parameter declaration.\n\/\/\/ For example, `_ element: E` and `to storage: Storage` in `func copy(_ element: E, to storage: Storage)`.",
      "location" : "FunctionParameter.swift:15",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "Keywordable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Keywordable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains keyword.",
      "location" : "Keywordable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "ContentDataSource",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol ContentDataSource: AnyObject",
      "modifiers" : [
        "public"
      ],
      "location" : "ContentGenerator.swift:28",
      "inheritance" : [
        "AnyObject"
      ]
    }
  },
  {
    "name" : "Codable",
    "type" : "root"
  },
  {
    "name" : "DefaultConsoleDestination",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class DefaultConsoleDestination: LoggerDestinationProtocol",
      "modifiers" : [
        "public",
        "final"
      ],
      "docs" : "\/\/\/ Default console destination that print log strings.",
      "location" : "DefaultConsoleDestination.swift:13",
      "inheritance" : [
        "LoggerDestinationProtocol"
      ]
    }
  },
  {
    "name" : "DirectedGraph",
    "type" : "class",
    "metadata" : {
      "declaration" : "class DirectedGraph<Content: Hashable>",
      "modifiers" : [

      ],
      "generics" : [
        "Content: Hashable"
      ],
      "location" : "DirectedGraph.swift:12",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "ClassDeclarationTests",
    "type" : "class",
    "metadata" : {
      "declaration" : "final class ClassDeclarationTests: XCTestCase",
      "modifiers" : [
        "final"
      ],
      "location" : "ClassDeclarationTests.swift:14",
      "inheritance" : [
        "XCTestCase"
      ]
    }
  },
  {
    "name" : "DeclarationDependencyMemeberKind",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum DeclarationDependencyMemeberKind: Equatable, Hashable",
      "modifiers" : [
        "public"
      ],
      "location" : "DeclarationDependencyMemeberKind.swift:12",
      "inheritance" : [
        "Equatable",
        "Hashable"
      ]
    }
  },
  {
    "name" : "DeclarationAssembly",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class DeclarationAssembly",
      "modifiers" : [
        "public",
        "final"
      ],
      "docs" : "\/\/\/ Stores all declarations found in some scope, for example, project or file.",
      "location" : "DeclarationAssembly.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "ComputableExpression",
    "type" : "root"
  },
  {
    "name" : "FunctionDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct FunctionDeclaration: Declaration, Wrappable, Modifiable, Keywordable, GenericParametable, GenericRequirementable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ A function declaration.",
      "location" : "FunctionDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Wrappable",
        "Modifiable",
        "Keywordable",
        "GenericParametable",
        "GenericRequirementable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "NodeContentItem",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct NodeContentItem: Encodable",
      "modifiers" : [
        "public"
      ],
      "location" : "ContentGenerator.swift:33",
      "inheritance" : [
        "Encodable"
      ]
    }
  },
  {
    "name" : "LocationMeta",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct LocationMeta: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Meta information about the row location in some file.",
      "location" : "LocationMeta.swift:13",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "ParserProtocol",
    "type" : "root"
  },
  {
    "name" : "LoggerProtocol",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol LoggerProtocol",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Interface to work with logger.",
      "location" : "LoggerProtocol.swift:13",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "ContentGenerator",
    "type" : "class",
    "metadata" : {
      "declaration" : "public final class ContentGenerator",
      "modifiers" : [
        "public",
        "final"
      ],
      "location" : "ContentGenerator.swift:60",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "XCTestCase",
    "type" : "root"
  },
  {
    "name" : "AccessorType",
    "type" : "enum",
    "metadata" : {
      "declaration" : "public enum AccessorType: String, Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "location" : "VariableDeclaration.swift:102",
      "inheritance" : [
        "String",
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "Declaration",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Declaration: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration type.",
      "location" : "Declaration.swift:13",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  },
  {
    "name" : "Error",
    "type" : "root"
  },
  {
    "name" : "VariableDeclaration",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct VariableDeclaration: Declaration, Namable, Keywordable, Wrappable, Modifiable, LocationMetaHolder, FileMetaHolder, DocStringMetaHolder",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Variable(including top-level) declaration",
      "location" : "VariableDeclaration.swift:14",
      "inheritance" : [
        "Declaration",
        "Namable",
        "Keywordable",
        "Wrappable",
        "Modifiable",
        "LocationMetaHolder",
        "FileMetaHolder",
        "DocStringMetaHolder"
      ]
    }
  },
  {
    "name" : "Namable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Namable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains name.",
      "location" : "Namable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "ComputableExpression",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol ComputableExpression",
      "modifiers" : [
        "public"
      ],
      "location" : "SpecialOctoSystem.swift:64",
      "inheritance" : [

      ]
    }
  },
  {
    "name" : "DocStringMetaHolder",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol DocStringMetaHolder: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains meta information about its docstring.",
      "location" : "DocStringMetaHolder.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "Inheritable",
    "type" : "protocol",
    "metadata" : {
      "declaration" : "public protocol Inheritable: Declaration",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Declaration that contains information about inheritance.",
      "location" : "Inheritable.swift:13",
      "inheritance" : [
        "Declaration"
      ]
    }
  },
  {
    "name" : "GenericRequirement",
    "type" : "struct",
    "metadata" : {
      "declaration" : "public struct GenericRequirement: Equatable, Hashable, Codable",
      "modifiers" : [
        "public"
      ],
      "docs" : "\/\/\/ Generic requirement declaration. For example, `Element: Codable` and `Identifier == UUID`\n\/\/\/ from `where Element: Codable, Identifier == UUID`.",
      "location" : "GenericRequirement.swift:15",
      "inheritance" : [
        "Equatable",
        "Hashable",
        "Codable"
      ]
    }
  }
];var rawLinksData = [
  {
    "target" : "XCTestCase",
    "source" : "ClassDeclarationTests"
  },
  {
    "source" : "ProtocolDeclarationTests",
    "target" : "XCTestCase"
  },
  {
    "source" : "StructDeclarationTests",
    "target" : "XCTestCase"
  },
  {
    "source" : "SpecialOctoSystemTests",
    "target" : "XCTestCase"
  },
  {
    "target" : "ComputableExpression",
    "source" : "MathExpression"
  },
  {
    "source" : "MathExpression",
    "target" : "Codable"
  },
  {
    "source" : "MultiplicationExpression",
    "target" : "MathExpression"
  },
  {
    "target" : "MathExpression",
    "source" : "AdditionExpression"
  },
  {
    "target" : "AdditionExpression",
    "source" : "PrettyAdditionExpression"
  },
  {
    "target" : "LoggerProtocol",
    "source" : "DefaultLogger"
  },
  {
    "target" : "LoggerDestinationProtocol",
    "source" : "DefaultConsoleDestination"
  },
  {
    "source" : "Parser",
    "target" : "ParserProtocol"
  },
  {
    "source" : "DeclarationVisitor",
    "target" : "SyntaxVisitor"
  },
  {
    "source" : "DeclarationDependencyMember",
    "target" : "Hashable"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "Declaration"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "NestedlyNamable"
  },
  {
    "target" : "Keywordable",
    "source" : "EnumDeclaration"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "Wrappable"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "Modifiable"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "GenericParametable"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "Inheritable"
  },
  {
    "target" : "GenericRequirementable",
    "source" : "EnumDeclaration"
  },
  {
    "source" : "EnumDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "EnumDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "EnumDeclaration"
  },
  {
    "source" : "StructDeclaration",
    "target" : "Declaration"
  },
  {
    "source" : "StructDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "StructDeclaration",
    "target" : "NestedlyNamable"
  },
  {
    "source" : "StructDeclaration",
    "target" : "Keywordable"
  },
  {
    "target" : "Wrappable",
    "source" : "StructDeclaration"
  },
  {
    "source" : "StructDeclaration",
    "target" : "Modifiable"
  },
  {
    "target" : "GenericParametable",
    "source" : "StructDeclaration"
  },
  {
    "source" : "StructDeclaration",
    "target" : "Inheritable"
  },
  {
    "source" : "StructDeclaration",
    "target" : "GenericRequirementable"
  },
  {
    "target" : "LocationMetaHolder",
    "source" : "StructDeclaration"
  },
  {
    "source" : "StructDeclaration",
    "target" : "FileMetaHolder"
  },
  {
    "source" : "StructDeclaration",
    "target" : "DocStringMetaHolder"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "Declaration"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "Wrappable"
  },
  {
    "target" : "Modifiable",
    "source" : "FunctionDeclaration"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "Keywordable"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "GenericParametable"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "GenericRequirementable"
  },
  {
    "source" : "FunctionDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "FunctionDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "FunctionDeclaration"
  },
  {
    "target" : "Declaration",
    "source" : "CaseDeclaration"
  },
  {
    "source" : "CaseDeclaration",
    "target" : "Wrappable"
  },
  {
    "source" : "CaseDeclaration",
    "target" : "Modifiable"
  },
  {
    "source" : "CaseDeclaration",
    "target" : "Keywordable"
  },
  {
    "target" : "Namable",
    "source" : "CaseDeclaration"
  },
  {
    "target" : "LocationMetaHolder",
    "source" : "CaseDeclaration"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "CaseDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "CaseDeclaration"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "Declaration"
  },
  {
    "target" : "Wrappable",
    "source" : "TypealiasDeclaration"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "Keywordable"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "GenericParametable"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "GenericRequirementable"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "TypealiasDeclaration"
  },
  {
    "source" : "TypealiasDeclaration",
    "target" : "DocStringMetaHolder"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "Declaration"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "Keywordable"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "Wrappable"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "Modifiable"
  },
  {
    "target" : "Inheritable",
    "source" : "ProtocolDeclaration"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "GenericRequirementable"
  },
  {
    "source" : "ProtocolDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "ProtocolDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "ProtocolDeclaration"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "Declaration"
  },
  {
    "target" : "Keywordable",
    "source" : "ImportDeclaration"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "Wrappable"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "Modifiable"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "source" : "ImportDeclaration",
    "target" : "FileMetaHolder"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "ImportDeclaration"
  },
  {
    "target" : "Declaration",
    "source" : "ActorDeclaration"
  },
  {
    "source" : "ActorDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "ActorDeclaration",
    "target" : "NestedlyNamable"
  },
  {
    "source" : "ActorDeclaration",
    "target" : "Keywordable"
  },
  {
    "target" : "Wrappable",
    "source" : "ActorDeclaration"
  },
  {
    "target" : "Modifiable",
    "source" : "ActorDeclaration"
  },
  {
    "target" : "GenericParametable",
    "source" : "ActorDeclaration"
  },
  {
    "source" : "ActorDeclaration",
    "target" : "Inheritable"
  },
  {
    "target" : "GenericRequirementable",
    "source" : "ActorDeclaration"
  },
  {
    "source" : "ActorDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "ActorDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "ActorDeclaration"
  },
  {
    "target" : "Declaration",
    "source" : "ClassDeclaration"
  },
  {
    "target" : "Namable",
    "source" : "ClassDeclaration"
  },
  {
    "source" : "ClassDeclaration",
    "target" : "NestedlyNamable"
  },
  {
    "target" : "Keywordable",
    "source" : "ClassDeclaration"
  },
  {
    "target" : "Wrappable",
    "source" : "ClassDeclaration"
  },
  {
    "source" : "ClassDeclaration",
    "target" : "Modifiable"
  },
  {
    "source" : "ClassDeclaration",
    "target" : "GenericParametable"
  },
  {
    "target" : "Inheritable",
    "source" : "ClassDeclaration"
  },
  {
    "source" : "ClassDeclaration",
    "target" : "GenericRequirementable"
  },
  {
    "target" : "LocationMetaHolder",
    "source" : "ClassDeclaration"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "ClassDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "ClassDeclaration"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "Declaration"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "Namable"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "Keywordable"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "Wrappable"
  },
  {
    "target" : "Modifiable",
    "source" : "VariableDeclaration"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "VariableDeclaration"
  },
  {
    "source" : "VariableDeclaration",
    "target" : "DocStringMetaHolder"
  },
  {
    "source" : "Accessor",
    "target" : "Equatable"
  },
  {
    "target" : "Hashable",
    "source" : "Accessor"
  },
  {
    "source" : "Accessor",
    "target" : "Codable"
  },
  {
    "target" : "Declaration",
    "source" : "AssociatedTypeDeclaration"
  },
  {
    "target" : "Wrappable",
    "source" : "AssociatedTypeDeclaration"
  },
  {
    "source" : "AssociatedTypeDeclaration",
    "target" : "Modifiable"
  },
  {
    "source" : "AssociatedTypeDeclaration",
    "target" : "Keywordable"
  },
  {
    "source" : "AssociatedTypeDeclaration",
    "target" : "Namable"
  },
  {
    "target" : "NestedlyNamable",
    "source" : "AssociatedTypeDeclaration"
  },
  {
    "target" : "LocationMetaHolder",
    "source" : "AssociatedTypeDeclaration"
  },
  {
    "source" : "AssociatedTypeDeclaration",
    "target" : "FileMetaHolder"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "AssociatedTypeDeclaration"
  },
  {
    "target" : "Declaration",
    "source" : "ExtensionDeclaration"
  },
  {
    "source" : "ExtensionDeclaration",
    "target" : "Wrappable"
  },
  {
    "target" : "Modifiable",
    "source" : "ExtensionDeclaration"
  },
  {
    "source" : "ExtensionDeclaration",
    "target" : "Keywordable"
  },
  {
    "target" : "Namable",
    "source" : "ExtensionDeclaration"
  },
  {
    "source" : "ExtensionDeclaration",
    "target" : "NestedlyNamable"
  },
  {
    "target" : "Inheritable",
    "source" : "ExtensionDeclaration"
  },
  {
    "target" : "GenericRequirementable",
    "source" : "ExtensionDeclaration"
  },
  {
    "source" : "ExtensionDeclaration",
    "target" : "LocationMetaHolder"
  },
  {
    "target" : "FileMetaHolder",
    "source" : "ExtensionDeclaration"
  },
  {
    "target" : "DocStringMetaHolder",
    "source" : "ExtensionDeclaration"
  },
  {
    "source" : "FunctionParameter",
    "target" : "Equatable"
  },
  {
    "source" : "FunctionParameter",
    "target" : "Hashable"
  },
  {
    "target" : "Codable",
    "source" : "FunctionParameter"
  },
  {
    "target" : "Equatable",
    "source" : "GenericRequirement"
  },
  {
    "target" : "Hashable",
    "source" : "GenericRequirement"
  },
  {
    "source" : "GenericRequirement",
    "target" : "Codable"
  },
  {
    "target" : "Equatable",
    "source" : "GenericParameter"
  },
  {
    "source" : "GenericParameter",
    "target" : "Hashable"
  },
  {
    "source" : "GenericParameter",
    "target" : "Codable"
  },
  {
    "target" : "Equatable",
    "source" : "Wrapper"
  },
  {
    "target" : "Hashable",
    "source" : "Wrapper"
  },
  {
    "target" : "Codable",
    "source" : "Wrapper"
  },
  {
    "target" : "Equatable",
    "source" : "Parameter"
  },
  {
    "source" : "Parameter",
    "target" : "Hashable"
  },
  {
    "source" : "Parameter",
    "target" : "Codable"
  },
  {
    "target" : "CustomStringConvertible",
    "source" : "Parameter"
  },
  {
    "source" : "FunctionSignature",
    "target" : "Equatable"
  },
  {
    "source" : "FunctionSignature",
    "target" : "Hashable"
  },
  {
    "target" : "Codable",
    "source" : "FunctionSignature"
  },
  {
    "target" : "Equatable",
    "source" : "FileMeta"
  },
  {
    "source" : "FileMeta",
    "target" : "Hashable"
  },
  {
    "source" : "FileMeta",
    "target" : "Codable"
  },
  {
    "source" : "Modifier",
    "target" : "Equatable"
  },
  {
    "source" : "Modifier",
    "target" : "Hashable"
  },
  {
    "source" : "Modifier",
    "target" : "Codable"
  },
  {
    "source" : "LocationMeta",
    "target" : "Equatable"
  },
  {
    "target" : "Hashable",
    "source" : "LocationMeta"
  },
  {
    "source" : "LocationMeta",
    "target" : "Codable"
  },
  {
    "target" : "Equatable",
    "source" : "DocStringMeta"
  },
  {
    "source" : "DocStringMeta",
    "target" : "Hashable"
  },
  {
    "target" : "Codable",
    "source" : "DocStringMeta"
  },
  {
    "source" : "C",
    "target" : "Hashable"
  },
  {
    "target" : "Encodable",
    "source" : "NodeContentItem"
  },
  {
    "source" : "Metadata",
    "target" : "Encodable"
  },
  {
    "target" : "UInt8",
    "source" : "LogLevel"
  },
  {
    "target" : "Comparable",
    "source" : "LogLevel"
  },
  {
    "target" : "Hashable",
    "source" : "LogLevel"
  },
  {
    "source" : "LogLevel",
    "target" : "CaseIterable"
  },
  {
    "source" : "GraphError",
    "target" : "UInt8"
  },
  {
    "target" : "Error",
    "source" : "GraphError"
  },
  {
    "source" : "DeclarationDependencyMemeberKind",
    "target" : "Equatable"
  },
  {
    "source" : "DeclarationDependencyMemeberKind",
    "target" : "Hashable"
  },
  {
    "source" : "DependencyError",
    "target" : "Error"
  },
  {
    "target" : "String",
    "source" : "AccessorType"
  },
  {
    "target" : "Equatable",
    "source" : "AccessorType"
  },
  {
    "source" : "AccessorType",
    "target" : "Hashable"
  },
  {
    "source" : "AccessorType",
    "target" : "Codable"
  },
  {
    "source" : "Relation",
    "target" : "String"
  },
  {
    "source" : "Relation",
    "target" : "Equatable"
  },
  {
    "source" : "Relation",
    "target" : "Hashable"
  },
  {
    "target" : "Codable",
    "source" : "Relation"
  },
  {
    "source" : "ParserError",
    "target" : "Error"
  },
  {
    "target" : "Declaration",
    "source" : "Inheritable"
  },
  {
    "target" : "Declaration",
    "source" : "GenericRequirementable"
  },
  {
    "target" : "Declaration",
    "source" : "Modifiable"
  },
  {
    "target" : "Declaration",
    "source" : "Namable"
  },
  {
    "source" : "Wrappable",
    "target" : "Declaration"
  },
  {
    "target" : "Declaration",
    "source" : "FileMetaHolder"
  },
  {
    "target" : "Declaration",
    "source" : "GenericParametable"
  },
  {
    "target" : "Declaration",
    "source" : "LocationMetaHolder"
  },
  {
    "source" : "NestedlyNamable",
    "target" : "Declaration"
  },
  {
    "source" : "Declaration",
    "target" : "Equatable"
  },
  {
    "target" : "Hashable",
    "source" : "Declaration"
  },
  {
    "source" : "Declaration",
    "target" : "Codable"
  },
  {
    "target" : "Declaration",
    "source" : "DocStringMetaHolder"
  },
  {
    "target" : "Declaration",
    "source" : "Keywordable"
  },
  {
    "target" : "AnyObject",
    "source" : "ContentDataSource"
  }
];