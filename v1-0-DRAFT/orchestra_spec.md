
# Introduction

![](media/FIXorchestraLogo.png)

## Objectives

FIX Orchestra was conceived as **machine readable rules of engagement**
between counterparties. As such, it is a standard for exchange of
metadata about the behavior of FIX applications. Orchestra is intended
to cut time to onboard counterparties.

The contents of Orchestra files are machine readable (that is, processed
as data) and may include:

  - Message structure by each scenario, implemented as an extension of
    FIX Repository.

  - Accepted values of enumerations by message scenario

  - Workflow: when I send this message type under this condition, what
    can I expect back?

  - How external states affect messages, e.g. market phases

  - Express a condition such as for a conditionally required field using
    a Domain Specific Language (DSL)

  - Document and exchange the Algorithmic Trading Definition Language
    (FIXatdl) files associated with a FIX service offering

  - FIX session identification and transport configuration

From the contents, firms and vendors will be enabled to develop tools to
automate configuration of FIX engines and applications, and generation
of code, test cases, and documentation. The various aspects are not an
all-or-nothing proposition, however. Users may implement only the
features that they find most beneficial and add features as needed.

Orchestra supports but does not change FIX protocol itself in any way,
nor does it obsolete existing FIX engines or tools.

## Protocol coverage

The features of Orchestra are intended to be generic and capable of
covering both FIX and non-FIX messaging protocols. One of the
foundational features to support non-FIX protocols is the ability to
describe any set of datatypes, not just FIX datatypes (see the [Datatypes](#datatypes)
section below).

## Design principles

As a standard for delivering metadata about FIX messages and application
behavior, Orchestra relies on technologies that are well supported
across all popular platforms and programming languages, particularly XML
and XML Schema.

Since Orchestra is primarily used at design time or compile time rather
than run time, high performance characteristics such as low latency are
not a major concern.

In future, Orchestra may be ported to alternative technologies,
particularly Web Ontology Language (OWL). However, the primary XML
technologies will continue to be supported for the foreseeable future.

## Glossary

**Actor**—either a counterparty to a FIX session or an external entity
that holds state relevant to application or session behavior. An actor
can take actions such as assigning state or transitioning a state
machine, and it can send messages.

**Code set**—A finite set of the valid values of a data element. Each
unique valid value is called a code.

**Datatype**–the value space of a data element, possibly including
enumerated values, precision or range. Some types have additional
attributes, e.g. epoch and time zone of a date. Value space is at the
application layer (layer 7 of the OSI model).

**Discriminator**—a field that can modify the value space of another
field. The combination of the value field and its discriminator is
variously called a choice, discriminated union, tagged union, or
variant.

**Encoding**–a wire format for data representation. Also known as
lexical space or the presentation layer (layer 6) in a protocol stack.

**Extension Pack (EP)**–incremental extension of the FIX application
layer, aka *FIX Latest*.

**Lexical space**–the representation of a data element. It belongs to
the presentation layer. For character-based encodings, it is defined as
a particular sequence of characters. For binary encodings, it may
involve mapping to primitive data types supported by computing
platforms.

**Pedigree**–recorded history of an artifact.

**Provenance**–a record of ownership of an artifact.

**Scenario**—a use case of a message type and its components.

**Semantic**—pertaining to the meaning of a message element, regardless
of its representation.

**Session protocol**–a protocol concerned with the reliable delivery
of messages over a transport. Layer 5 in the OSI protocol model.

**State machine**–A behavior model that has finite, discrete values
called states and defined transitions between states.

**Tag**–a unique numeric identifier of a message element, especially a
field identifier.

**Value space**–the type of a data element and its possible range of
values. Value space belongs to the application layer (semantics) and
should be independent of encoding (presentation layer) and programming
language.

**XML schema**–defines the elements and attributes that may appear in an
XML document. The Orchestra schemas are defined in W3C (XSD) schema
language since it is the most widely adopted format for XML schemas.

## Documentation

### Specification terms

The following key words in this document are to be interpreted as described in
[Internet Engineering Task Force RFC2119](http://www.apps.ietf.org/rfc/rfc2119.html).

- These terms indicate an absolute requirement for implementations of the standard:
"**must**", or "**required**".

- This term indicates an absolute prohibition: "**must not**".

- These terms indicate that a feature is allowed by the standard but not
required: "**may**", "**optional**". An implementation that does not
provide an optional feature must be prepared to interoperate with one
that does.

- These terms give guidance, recommendation or best practices:
"**should**" or "**recommended**". A recommended choice among
alternatives is described as "**preferred**".

- These terms give guidance that a practice is not recommended: "**should
not**" or "**not recommended**".

### Document format

In this document, the following formats are used for technical specifications
and data examples.

XML element and attribute names as well as FIX field and message names
appear in this font: `codeSet`

This is a sample XML snippet:

```xml
<fixr:field id="59" name="TimeInForce" type="TimeInForceCodeSet"/>
```

## References

### Related FIX Standards

For FIX semantics, see the current FIX message specification, which is
currently [FIX Latest](https://www.fixtrading.org/online-specification/).

### Dependencies on other standards

Orchestra imports [Dublin Core XML schemas version 2008-02-11](http://dublincore.org/schemas/xmls/) for artifact
provenance. Dublin Core is standardized as IETF RFC 5013 and ISO 15836.

XML 1.1 schema standards are located at [W3C XML Schema](http://www.w3.org/XML/Schema.html#dev)

[XML Inclusions (XInclude) Version 1.1](https://www.w3.org/TR/xinclude-11/)

Incremental changes to an XML file may be represented by the format described in [IETF RFC 5261](https://tools.ietf.org/html/rfc5261).

Textual encoding of security keys must conform to [IETF RFC 7468](https://tools.ietf.org/html/rfc7468).

Documentation content types should be chosen from the registry of media types (formerly known as MIME) maintained by the Internet Assigned Numbers Authority (IANA). See the registry of text media types at [Media Types](https://www.iana.org/assignments/media-types/media-types.xhtml#text). [Markdown](https://tools.ietf.org/html/rfc7763) is recommended for rich text while `text/plain` is the default.

[ISO 8601:2019](https://www.iso.org/standard/70907.html) Data elements and interchange formatsInformation
interchange - Representation of dates and times. Used for representation
of dates, times, and time intervals in DSL expressions.

# Metamodel

Orchestra is based on two metamodels. The repository metamodel contains concepts for message structures and workflow while the interfaces metamodel has concepts for service offerings and sessions.

Each of the two metamodels are implemented in their respective XML schemas. Any other representations that may be developed in future, such as semantic ontologies, should be considered implementations of these common metamodels.

The metamodels presented do not strictly conform to the UML Meta-Object Facility architecture (MOF).

## Message structures

The UML metamodel depicted below is a conceptual view of message
structures.

![](media/FIX-Repository-MetaModel.png)

### Message structure abstractions

**Field**–carries a specific business meaning (semantics) as described
in FIX specifications or other protocol. A pointer to a field is a **fieldRef**. The data domain of a field is either a datatype or a code
set.

**Datatype**–the value space of a class of fields. FIX has about 20
datatypes.

**Code set**–a set of valid values of a field. They must all be of the
same datatype.

**Component**–a sequence of fields and nested components. There are
two types of components, common block and repeating group. A common
block is a component designed to be specified once in detail but reused in
multiple message types by reference. A pointer to a component is a **componentRef**.

**Group, or repeating group**–like a common block but with one
additional feature: it represents an *array of* blocks to be sent on the
wire. A pointer to a group is a **groupRef**.

**Message**–a unit of information sent on the wire between
counterparties. A message is composed of components and fields. A
pointer to a message is a **messageRef**.

### General Purpose Datatypes

Pointer and array abstractions are defined by the standard ISO 11404. The
code set abstraction is described in that standard as “state” type.

## Interfaces

The interface metamodel is an abstraction of service offerings and
session provisioning. This UML model depicts the main classes.

![](media/Interfaces-1.png)

![](media/Interfaces-2.png)

### Interface abstractions

**Protocol**—a standard for communications. The Open Systems
Interconnection model (OSI) defines protocols as a layered stack,
including application layer and user interface at the top, presentation
layer (encoding), session layer, and transport layer. Each protocol
depends on lower layers for services. Layers below transport layer are
out of scope for Orchestra.

Any message-oriented protocol may have an orchestration attribute that
consists of a URI. It is a link to an Orchestra file that describes
message structures and workflow.

**Service**—a service offering by a counterparty. A service is an
application layer protocol.

**Interface**—a collection of protocols and services exposed by a
counterparty. A counterparty may offer more than one interface for
different purposes. An interface may be configured for one or more
service offerings and all the protocols that make up a communication
stack. Also, an interface may contain any number of session
configurations.

**Session**—a specific usage of an interface. A session has one or more
identifiers. It inherits services and protocols from its parent
interface, but it may have further refinement or overrides of protocol
settings, such as a transport address.

# Orchestra Repository XML Schema

## Repository XML Schema (XSD)

The Repository XML schema is used to control the format of XML files that
describe message structures. Additionally it contains elements and attributes
for work flow, state variables, conditional logic and so forth.

### Conformance

All published Orchestra repository files **must** conform to the
standard repository XML schema. This can be validated with common XML parsers and
related tools.

### Schema location

The XML schema is currently available in GitHub project fix-orchestra module
[repository](https://github.com/FIXTradingCommunity/fix-orchestra/tree/master/repository).
It will be made available via the web at a URL consistent with its XML namespace.

### Root element

The root element an Orchestra respository XML file is `<repository>`. An Orchestra
repository file contains all the message structures and workflow
elements pertaining to a single protocol version. If an organization
supports multiple versions of FIX, it should supply an Orchestra file
for each.

The `name` attribute of `<repository>` identifies an implementation of a
protocol. The name should remain stable over minor revisions. The
`version` attribute should, on the other hand, be unique for any
substantive change to the protocol.

This snippet shows that element with required namespaces and attributes:

```xml
<fixr:repository name="FIX.5.0SP2" version="FIX.5.0SP2_EP253"
xmlns="http://purl.org/dc/elements/1.1/"
xmlns:fixr="http://fixprotocol.io/2020/orchestra/repository"
xmlns:dc="http://purl.org/dc/terms/"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://fixprotocol.io/2020/orchestra/repository FixRepository2020.xsd">
```

#### Repository attributes

Attributes of the whole repository are set on the root element. The `name`
and `version` attributes are required. Name should be stable even when
minor changes are made to an Orchestra file while version should be
updated for incremental changes.

By default, the language for conditional expressions is the Score DSL
(See section [Score DSL](#score-dsl) below). However, this may be overridden by setting a value
to the attribute `expressionLanguage`.

### Support for XInclude

Several of the elements in the schema support XML Inclusions (XInclude). This allows assembly of an Orchestra XML infoset from multiple, reusable XML files. For example, several service offerings may share datatypes, fields, and even common message types.

### Supplementary documentation

See the separate document “FixRepository2020.html” for a detailed
technical reference for the Orchestra and Repository XML schema. The
remainder of this section serves as an overview and explains motivations
for the design.

### Protocol relationship

The schema was primarily designed to describe metadata about FIX
protocols. However, it was also intended to be generic enough to work
with other common financial industry protocols, especially when FIX is
used in combination with other protocols, or a translation must be
performed between protocols.

Usage should be supported for all phases of financial industry
workflows, including pre-trade, trade, and post-trade flows.

## Content ownership and history

### Provenance

The `<metadata>` element is used to identify a particular Orchestra file
and the issuer of that file. It can contain any of the elements defined
by the Dublin Core XML schema. Recommended elements include title,
publisher, date, and rights.

**Example:** Metadata

```xml
<fixr:metadata>
	<dc:title>Orchestra Example</dc:title>
	<dc:creator>Millennium IT</dc:creator>
	<dc:publisher>FIX Trading Community</dc:publisher>
	<dc:rights>Copyright 2019, FIX Protocol, Limited</dc:rights>
	<dc:date>2019-01-09T16:09:16.904-06:00</dc:date>
	<dc:format>Orchestra Repository</dc:format>
	<dc:contributor>RepositoryCompressor</dc:contributor>
</fixr:metadata>
```

### Pedigree

Most message elements in the schema support a complete history of
creation, change and potentially deprecation with support of attribute group
`entityAttribGrp`. Each historical event should be qualified by its extension pack (EP). In the past, they were also qualified by protocol version. However, each EP now produces FIX Latest; protocol versions will no longer change.

**Example:** A field that was added and updated

```xml
<fixr:field type="String" id="17" name="ExecID" abbrName="ExecID" added="FIX.2.7" updated="FIX.5.0SP1" updatedEP="95">
```
\
**Example:** Code element that was deprecated

```xml
<code value="3" name="LocalCommission" added="FIX.4.0"
deprecated="FIX.5.0SP2" deprecatedEP="204"/>
```

## Features for document and FIXML generation

The XML schema retains features that have long been used to generate FIX
documentation and other outputs. These elements are optional.

### Categories

The `<categories>` element tree is used to associate FIX elements to
business areas, such as single general order handling, market data, and so
forth, for documentation generation. Also, categories are used to
organize FIXML schema files.

### Sections

The `<sections>` element tree names higher level business processes. Typically, a section containes multiple categories. Traditionally,
they have been organized around pre-trade, trade, and post-trade
information flows.

### Metadata about any element

The schema provides features to provide metadata about almost any
element. All such metadata appears under element `<annotation>`. There
is no limit to the number of metadata entries per `<annotation>`
element.

#### Documentation

A `<documentation>` element can carry any description of its ancestor
element. The content (text node) may be of any format, such as XHTML,
markdown, or HTML5. The XML parser is instructed not to validate the
free-form content. Tools such as XSLT may be used to extract
documentation from an Orchestra file and compile external documents.

Multiple languages can be supported by specifying the language of each
element in its `langId` attribute. Also, multiple categories of
documentation are supported by populating the `purpose` attribute.
Suggested values of purpose include "SYNOPSIS", "ELABORATION",
"EXAMPLE", and "DISPLAY".

**Example:** Field element with documentation.

```xml
<fixr:field id="45" name="RefSeqNum">
	<fixr:annotation>
		<fixr:documentation langId="en-us" purpose="SYNOPSIS">
		Reference message sequence number
		</fixr:documentation>
	</fixr:annotation>
</fixr:field>
```
\
Optionally, a `<documentation>` element may be qualified by media type to
support rich text. The default value of attribute `contentType` is
"text/plain". If a rich text encoding is embedded in the XML document,
appropriate XML namespaces may be required. An Orchestra file may be
rendered as polyglot markup, meaning that it is well-formed as both
XML and XHTML, a W3C recommendation.

**Example:** Documentation as polyglot markup.

```xml
xmlns:html="http://www.w3.org/1999/xhtml"

. . .

<fixr:field type="String" added="FIX.2.7" id="1" name="Account"
abbrName="Acct">
	<fixr:annotation>
		<fixr:documentation purpose="SYNOPSIS" contentType="text/html">
<html:p><html:b>Account mnemonic</html:b> as agreed between buy and sell sides, e.g. broker and institution or investor/intermediary and fund manager.</html:p>
		</fixr:documentation>
	</fixr:annotation>
</fixr:field>
```
\
Alternatively, documentation elements may set the media type in the `contentType` attribute to any text encoding registered with IANA.

**Example:** Documentation as markdown.

```xml
	<fixr:annotation>
		<fixr:documentation purpose="SYNOPSIS" contentType="text/markdown">
**Account mnemonic** as agreed between buy and sell sides, e.g. broker and institution or investor/intermediary and fund manager.
		</fixr:documentation>
	</fixr:annotation>
```

#### Appinfo

The `<appinfo>` element is similar to `<documentation>` in that it can
support multiple languages and multiple purposes. It has an additional
attribute, `specURL`, to cross-reference external documentation.

### Rendering hints

The optional attribute `rendering` may be used to suggest how a message or
element should be generated or rendered in a user interface. The value
of the attribute is free-form and is not validated by the Orchestra
schema.

## Unique identifiers

Practically all elements in the XML schema have a `name` attribute, a
numeric `id` attribute or both. These values must be unique within their
respective element types within a given Orchestra file. To avoid
collisions, names and IDs of deprecated elements should never be reused.

## Datatypes

A datatype is a context-free value space. That is, a domain of possible
values relatively free of business semantics. For a specific message
encoding protocol (presentation layer), a datatype is mapped to the
syntax of that encoding, also known as lexical space.

Some fields are specified as a set of valid values. This is known as
*code set*, and it can be thought of as a specialized datatype (see the [Code sets](#code-sets) section below).

Each datatype is described by a `<datatype>` element, a child of
`<datatypes>`.

### FIX datatypes

FIX fields are categorized into roughly 20 datatypes. A datatype should
be defined in terms of its value space, the range of its possible
values, not in terms of its lexical space, its encoding format. In fact,
a FIX datatype may be mapped to any number of wire formats (see the [datatype mappings](#datatype-mappings)
section below).

A datatype may optionally inherit properties from a type specified by
the `baseType` attribute. For example, Qty datatype, used by fields like
OrderQty(38), has baseType of float, a more generic FIX datatype.

Generally, FIX datatypes for FIX protocols need to be defined only once and
are copied from the baseline standard. However, the datatypes section
may contain different definitions for non-FIX protocols.

### Datatype mappings

A `<datatype>` element may contain `<mappedDatatype>` elements
corresponding to any number of type systems. Type systems include XML,
SBE, GPB, JSON, and ISO 11404, a generic type taxonomy. An XML schema
mapping is obviously needed by FIXML.

The `standard` attribute of `<datatype>` tells which type system the
mapping is for. Its `base` attribute tells what the FIX datatype maps to
in the particular standard. For example, FIX type Qty maps to XML schema
type xs:decimal.

The `<mappedDatatype>` element allows any snippet of well-formed XML to
be pasted in as a child element that is a meaningful specification to an
encoding protocol.

The ISO/IEC 11404 General Purpose Datatypes standard contains a taxonomy
of programming language-independent types and enumerates their
characteristics. One of the benefits of following this standard is that
it will be easier to map FIX data types to other message standards, such
as ISO 20022 (SWIFT). Rather than creating numerous one-off mappings to
other type systems, is it likely more efficient to map each to ISO 11404
once, and then compare mappings in an associative model to identify the
commonalities. (The XML schema standard claims to derive its datatypes
from ISO 11404, but mapping to the generic standard is more precise and
comprehensive than filtering it through the XML interpretation.)

The lower and upper bounds of a bounded datatype may be set with
`minInclusive` and `maxExclusive` attributes.

**Example:** A FIX datatype with mappings to XML schema and General-Purpose Datatypes.

```xml
<fixr:datatype name="SeqNum" baseType="int">
	<fixr:mappedDatatype standard="XML" base="xs:positiveInteger"/>
	<fixr:mappedDatatype standard="ISO11404" base="Ordinal"/>
</fixr:datatype>
```

## Code sets

A code set contains a finite collection of valid values of a data
element. Each unique valid value is called a code. In the terminology of
ISO 11404, such a data element is called a “state”. (This is
distinguished from an enumeration, in which the order of values matters.
In a state, each of the values must be unique, but order is not
significant. Hence, the values collection is a set.)

In FIX and other protocols, many fields may share a code set. For
example, the SecurityIDSource and UnderlyingSecurityIDSource fields
share the same valid values, or code set.

A code set has an underlying datatype to tell its domain of possible
values. Codes may legally be of any type listed in the `<datatypes>`
section, but typically are int, char or String datatypes in FIX. In an
Orchestra file, a code value is presented as a string, but it should be
actually transmitted in the correct encoding for the datatype of the
code set. For example, if the datatype of a code set was “int”, value
“27” should be transmitted in a binary wire format for integer 27, not
as character “2” and then character “7”.

A `<codeSets>` element contains any number of `<codeSet>` child
elements. The schema allows multiple instances of `<codeSets>`
containers, each with a unique `name` attribute.

The names of code sets and datatypes share a common namespace and must
be unique within a schema. This constraint is enforced by the XML
schema.

### Internal code sets

Internal code sets are maintained in a Repository or Orchestra file by
the issuer. The `<code>` elements that belong to the code set are listed
explicitly.

#### Codes

An internal `<codeSet>` is a container for `<code>` elements. In the
schema, each code has a `name` attribute to tell its logical name, and a
`value` attribute to tell its value on the wire. Additionally, each
`<code>` element has a numeric `id` attribute.

Codes may be added to a code set over time, or existing codes may be
deprecated. The history of codes within a code set may be recorded using
the pedigree attributes of attribute group `entityAttribGrp`.

Codes may be documented with an `<annotation>` element tree.

**Example:** An internal code set.

```xml
<fixr:codeSet type="char" id="165" name="SettlInstSourceCodeSet"
scenario="base">
	<fixr:code value="1" added="FIX.4.1" id="165001" name="BrokerCredit"/>
	<fixr:code value="2" added="FIX.4.1" id="165002" name="Institution"/>
	<fixr:code value="3" added="FIX.4.3" id="165003" name="Investor"/>
</fixr:codeSet>
```

#### Scenarios

Code sets may have different supported codes in different scenarios. For
example, outbound ExecutionReport(35=8) messages may have more enriched view
of PartyRole(452) than is required on inbound order messages. Therefore, a
`<codeset>` may be qualified by its `scenario` attribute. The default
value of `scenario` is “base”, so the attribute need not be supplied if
there is only one form of a codeset.

Uniqueness of codeset scenarios is enforced by the XML schema, both as
the combination of `name` + `scenario` as well as `id` + `scenario`.

### External code sets

In some cases, FIX shares code sets with other protocols. Examples
include currency, language, and country codes defined by another
standard. This is called an external code set because the valid values
are maintained by the external standard, not within the Repository or
Orchestra file. To provide a reference to an external standard, use
`<codeSet>` attribute `specUrl`. Additional references can be supplied
with `<annotation>` elements.

In the case of an external code set, `<code>` elements are not listed in
the Orchestra file.

**Example:** An external code set CurrencyCode is defined as a FIX datatype Currency with valid
values defined by standard ISO 4217.

```xml
<fixr:codeSet name="CurrencyCode" type="Currency" specUrl="
http://www.iso.org/iso/home/store/catalogue_tc/catalogue_detail.htm?csnumber=64758">
```

## Fields

A field carries a specific business meaning (semantic) as described in
FIX specifications or another protocol. In the schema, a `<field>` element
is contained by parent element `<fields>`. The collection of fields
should be thought of as an append-only list; the id of a deprecated
field must not be reused. The pedigree attributes of attribute group
`entityAttribGrp` are used to tell the history of a field, including the
protocol version in which it was added.

In FIX, a field has two unique identifiers, numeric id, also known as
"tag", and a descriptive string name.

Like other message elements, a field may be documented with an
`<annotation>` element tree as described above. Also, the `baseCategory`
attribute may be used to categorize fields. There are several more
optional attributes which are described in the message structure section
below.

### Scenarios

Fields may have different scenarios either to vary annotations or to use
different code set scenarios for different use cases. The default value
of `scenario` is “base”, so the attribute need not be supplied if there is
only one form of a field.

Uniqueness of field scenarios is enforced by the XML schema, both as the
combination of `name` + `scenario` as well as `id` + `scenario`.

### Data domain of a field

Every field must have a data domain of either a `<datatype>` name or more
specifically, a collection of valid values specified by a `<codeSet>`
reference. In either case, the domain of a field is specified in its
`type` attribute. The attribute `type` refers to either a `<datatype>`
element or a `<codeSet>` element by its `name` attribute. In the case of a
`<codeSet>`, there is a level of indirection to its `type` attribute to
arrive at a `<datatype>`.

Since `<codeSet>` is also qualified by scenario, a field will link to
the code set of the same scenario. By default, “base” scenario field
links to “base” code set.

**Example:** A field with a code set and another with a datatype domain.

```xml
<fixr:field id="59" name="TimeInForce" type="TimeInForceCodeSet"/>
<fixr:field id="60" name="TransactTime" type="UTCTimestamp"/>
```

### Data fields

A field of data datatype is variable length. In FIX tag=value encoding,
the length of such a field is prefixed by a separate field of type
Length. In other encodings, the length is implicit in the presentation
protocol. For data fields, the associated Length field is referenced by the
`lengthId` attribute, a reference to its `id`
attribute.

**Example:** A data field and its corresponding Length field.

```xml
<field added="FIX.2.7" id="95" name="RawDataLength" type="Length"/>
<field added="FIX.2.7" id="96" name="RawData" type="data" lengthId="95"/>
```

### Discriminator fields

FIX contains fields for which its value domain is modified by another
field. This is variously called a choice, discriminated union, tagged
union, or variant. The field that modifies the range of values of
another field is called a discriminator. For example, SecurityIDSource
is the discriminator for the values of SecurityID. If the value of
SecurityIDSource is 4, then the value of SecurityID must be a valid
ISIN, and so forth. This relationship may be indicated in Orchestra by
adding the attribute `discriminatorId` to a field.

**Example:** A field modified by a discriminator.

```xml
<fixr:field added="FIX.2.7" id="48" name="SecurityID" type="String"
abbrName="ID" discriminatorId="22">
	<fixr:annotation>
		<fixr:documentation purpose="SYNOPSIS">
Security identifier value of SecurityIDSource (22) type (e.g. CUSIP, SEDOL, ISIN, etc). Requires ecurityIDSource.
		</fixr:documentation>
	</fixr:annotation>
</fixr:field>
```

### Overridable and fixed field attributes

Some attributes of a field, such as minimum and maximum values and
length, may be overridden for a particular usage in the message
structure that contains a field reference. However, the key identifiers
id and name as well as type attribute may not be overridden. It is
possible to override which codes of a code set are supported in a
particular scenario, however. See the message structure section below.

### Field value uniqueness

Some fields are required to be populated with unique values, either
globally or within a defined scope. A scope of uniqueness may be
specified with reference to other fields.

Uniqueness may be specified with the `<unique>` element within a rule
applied to either a field definition or a reference. The uniqueness of a
field may be specified for all uses of the field if a rule is placed as
a child of a `<field>` element, or it may apply to one use case of the
field by placing it within a `<fieldRef>` element.

A globally unique value is required for all instances of a field.

**Example:** Globally unique values.

```xml
<fixr:field id="11" name="ClOrdID" presence="required">  
  <fixr:rule>  
    <fixr:unique/>  
  </fixr:rule>
</fixr:field>
```
\
A key field provides the scope of uniqueness.

**Example:** Unique values per day

```xml
<fixr:fieldRef id="11" presence="required">  
  <fixr:rule>  
    <fixr:unique>  
      <fixr:fieldRef id="75"/>  
    </fixr:unique>  
  </fixr:rule>
</fixr:fieldRef>
```
\
A combination of fields defines scope of uniqueness.

**Example:** Unique values per day and market segment.

```xml
<fixr:fieldRef id="11" presence="required">  
  <fixr:rule>  
    <fixr:unique>  
      <fixr:fieldRef id="75"/>
      <fixr:fieldRef id="1300"/>  
    </fixr:unique>  
  </fixr:rule>
<fixr:fieldRef>
```

## Message structures

### Components

A component is a sequence of fields and nested components. There are two
types of components, common blocks and repeating groups. Simple
`<component>` blocks are contained by the `<components>` parent element
while `<group>` repeating groups are contained by the `<groups>`
parent element.

Like the messages that contain them, components and groups may be
overloaded for slightly different layouts for different scenarios.

#### Component identifiers

Like a field, a component has a numeric `id` attribute and a
string `name` attribute. The schema enforces uniqueness of the `id` and `name`
attributes among components.

Like a field, a component can be annotated for documentation
and carries pedigree attributes of attribute group `entityAttribGrp`.

The `scenario` attribute of a component identifies a use case; multiple
components may have the same name, but the combination of name and
scenario must be unique. Scenario has a default value of “base”, so if a
component only has one variation, there is no need to qualify it.

#### Common block

A common block component is designed to be specified once in detail but
reused in multiple message types by reference. An example of a common
block is “Instrument”. It is a collection of the possible fields
describing an instrument, and it is used in many FIX
messages. A common block is implemented as a `<component>` element in
the schema.

Rules about order of fields or nested components, if any, depend upon
the presentation protocol. Since Orchestra supports multiple encodings,
the order of fields in an Orchestra file is not guaranteed to match the
order on the wire.

**Example:** A component containing field references.

```xml
<fixr:component category="Common" added="FIX.4.4" id="1006" name="LegBenchmarkCurveData" abbrName="BnchmkCurve" scenario="base">
	<fixr:fieldRef id="676" scenario="base"/>
	<fixr:fieldRef id="677" scenario="base"/>
	<fixr:fieldRef id="678" scenario="base"/>
	<fixr:fieldRef id="679" scenario="base"/>
	<fixr:fieldRef id="680" scenario="base"/>
	<fixr:annotation>
		<fixr:documentation purpose="SYNOPSIS">
         The LegBenchmarkCurveData is used to convey the benchmark information used for pricing in a multi-legged Fixed Income security.
      </fixr:documentation>
</fixr:component>
```

#### Repeating group

A repeating group is like a common block but with one additional
feature: it represents an *array of* blocks to be sent on the wire. In
FIX tag=value encoding, a counter of datatype NumInGroup precedes the
array when transmitted. In other encodings, such as FIXML, the array is
implicit in the presentation protocol.

A repeating group is specified by a `<group>` element. It has a child
element to specify the associated NumInGroup field by id,
`<numInGroup>`.

Limits on the size of a repeating group may optionally be specified with
`implMinOccurs` and `implMaxOccurs` attributes. If those attributes are not
present, then the repeating has unbound size.

**Example:** A repeating group with member fields and reference to the NumInGroup field.

```xml
<fixr:group category="Common" id="1007" name="LegStipulations"
abbrName="Stip" added="FIX.4.4" scenario="base">
	<fixr:numInGroup id="683"/>
	<fixr:fieldRef added="FIX.4.4" id="688" scenario="base"
presence="optional"/>
	<fixr:fieldRef added="FIX.4.4" id="689" scenario="base"
presence="optional"/>
</fixr:group>
```

#### Component members

A component may contain reference elements of three types in any
combination. A component must contain at least one member.

  - A `<fieldRef>` element represents a field in a block or repeating
    group. It is a reference to a `<field>` element within the
    `<fields>` container by its `id` and `scenario` attributes.

  - A `<componentRef>` element represents a nested component. There is
    no limit in the schema to the level of nesting, although a
    presentation protocol may have rules about it, and there may be
    practical limits. The reference must match the referenced
    `<component>` on both `id` and `scenario` attributes.

  - A `<groupRef>` element similarly refers to a nested `<group>`
    repeating group element by its `id` and `scenario` attributes. Limits of
    the size of a particular instance of a repeating group may be
    overridden by setting `implMinOccurs` and `implMaxOccurs` attributes on
    the `<groupRef>` element.

**Example:** A component with all kinds of members.

```xml
<fixr:component category="Common" added="FIX.5.0SP2" addedEP="208"
id="4400" name="UnderlyingPaymentStreamCompoundingDates"
abbrName="CmpndgDts" scenario="base">
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42904"
scenario="base" presence="optional"/>
	<fixr:groupRef added="FIX.5.0SP2" addedEP="208" id="4401"
scenario="base" implMaxOccurs="unbounded" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42905"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42906"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42907"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42908"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42909"
scenario="base" presence="optional"/>
	<fixr:componentRef added="FIX.5.0SP2" addedEP="208" id="4404"
scenario="base" presence="optional"/>
	<fixr:componentRef added="FIX.5.0SP2" addedEP="208" id="4402"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42910"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42911"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42912"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42913"
scenario="base" presence="optional"/>
	<fixr:fieldRef added="FIX.5.0SP2" addedEP="208" id="42914"
scenario="base" presence="optional"/>
</fixr:component>
```

### Presence

Each of the members of a component or message, namely `<fieldRef>`, `<componentRef>` or `<groupRef>`, have a `presence` attribute. The
possible values of presence are:

  - **required**—the member MUST always be present in a message.

  - **optional**—the member MAY be present; it may be conditionally
    required based on a rule.

  - **forbidden**—the member MUST NOT be present.

  - **ignored**—the member MAY be present but is not processed by the
    receiving party, and thus, no validation is performed on it.

  - **constant**—the field has a constant value.

The receiver of a message with a forbidden element or lacking a required element may reject it using appropriate actions defined by the rules of engagement.

#### Constant field value

A field may be set to a constant value. A specific value of a field is
often useful to distinguish scenarios or use cases for a message type.
For example, values of ExecType(150) distinguish various scenarios of
ExecutionReport(35=8). Also, if a presentation protocol supports constants, a
constant field need not be transmitted on the wire.

**Example:** A constant field. SecurityIDSource is always code '1' (CUSIP).

```xml
<fixr:fieldRef id="22" presence="constant" value="1"/>
```

#### Default value of an optional field

For an optional field, a default value may be specified if the sender
does not provide the field.

**Example:** An optional field with a default value. TimeInForce(59) default is '0' (Day).

```xml
<fixr:fieldRef id="59" presence="optional" value="0"/>
```

#### Conditionally required field

The presence of a conditionally required field depends upon other fields
in a component or message. For example, StopPx(99) is required when OrdType(40)
is 3=Stop or 4=StopLimit. If OrdType(40) has any other value like Limit or
Market, then StopPx(99) is not required.

The condition that tells when a conditionally required field is required
is contained by a `<rule>` element tree under a `<fieldRef>`. A `<rule>`
element may contain an override of `presence` as well as certain other
field attributes. Each rule is specified by a `<when>` element that
gives the condition for the override. The XML content (text node) of the
`<when>` element is a conditional expression that follows a grammar
described in the conditional expressions section below. The attribute
override such as `presence=″required″` attribute is applied to the
`<when>` element.

**Example:** Rules for a conditionally required field.

```xml
<fixr:fieldRef id="99" presence="conditional">
	<fixr:rule name="StopOrderRequiresStopPx" presence="required">
		<fixr:when>OrdType == ^Stop</fixr:when>
	</fixr:rule>
	<fixr:rule name="LimitOrderForbidsStopPx" presence="forbidden">
		<fixr:when>OrdType \!= ^Stop</fixr:when>
	</fixr:rule>
</fixr:fieldRef>
```

#### Mutually exclusive component members

Sometimes members of a component or group are intended to be mutually exclusive. This is expressed by adding the attribute `which="oneOf"` to a `<component>` or `<group>` element. In a message that contains the component or group, *one and only one* of its mutually exclusive members must be present.

**Example:** The fields OrderQty(38) and CashOrderQty(152), and the nested component OrderQtyDataCIV are mutually exclusive members the OrderQtyData component.

```xml
<fixr:component category="Common" added="FIX.4.3" id="1011" name="OrderQtyData" abbrName="OrdQty" scenario="base" which="oneOf">
	<fixr:fieldRef added="FIX.4.3" id="38" scenario="base"/>
	<fixr:fieldRef added="FIX.4.3" id="152" scenario="base"/>
	<fixr:componentRef id="2011" scenario="base"/>
	<fixr:annotation>
		<fixr:documentation purpose="SYNOPSIS">
         The OrderQtyData component block contains the fields commonly used for indicating the amount or quantity of an order. Note that when this component block is marked as "required" in a message either one of these three fields must be used to identify the amount: OrderQty, CashOrderQty or OrderPercent (in the case of CIV).
		</fixr:documentation>
	</fixr:annotation>
</fixr:component>
<fixr:component category="Common" added="FIX.4.3" id="2011" name="OrderQtyDataCIV" abbrName="OrdQty" scenario="base">
	<fixr:fieldRef added="FIX.4.3" id="516" scenario="base" presence="required"/>
	<fixr:fieldRef added="FIX.4.3" id="468" scenario="base"/>
	<fixr:fieldRef added="FIX.4.3" id="469" scenario="base"/>
</fixr:component>
```

Similarly, the attribute `which="anyOf"` indicates that *at least one* of the members of a component must be present.

To require *all* of the members to be present, set `presence="required"` on each member.

### Message

A message in an Orchestra file describes a unit to be sent on the wire
between counterparties.

Like a `<component>`, a `<message>` element has `id` and `name` attributes.
It also has an `msgType` attribute, a short name. In tag=value encoding,
msgType is the value of the FIX field MsgType(35).

In FIX, a single MsgType(35) value is often reused for multiple use cases. For example,
an ExecutionReport(35=8), is overloaded for acceptance of an
order, rejection, execution, cancel confirmation, etc. In the Orchestra
schema, the `scenario` attribute is used to name each of those use cases.
Each of the variations of a single MsgType(35) value can have slightly different message
structures.

Another attribute of `<message>` called `flow` ties a message to an
exchange of messages between actors.

#### Message structure

The `<messages>` element contains any number of child `<message>`
elements. From the perspective of the XML schema, a `<message>` is very
similar to a `<component>`; they contain the same member types and share
most attributes. However, `<message>` is a top-level entity only; it
cannot be contained by other message parts, nor can messages be nested.

Unlike `<component>`, the parts of a message are contained by a child
`<structure>` element, which in turn holds `<fieldRef>`,
`<componentRef>` and `<groupRef>` elements.

**Example:** A message structure with a field, nested components, and a nested
repeating group.

```xml
<fixr:message name="TradingSessionList" id="100" msgType="BJ"
category="MarketStructureReferenceData" section="PreTrade">
	<fixr:structure>
		<fixr:componentRef id="1024" presence="required"/>
		<fixr:componentRef id="1057"/>
		<fixr:fieldRef id="335"/>
		<fixr:groupRef id="2099" presence="required"/>
		<fixr:componentRef id="1025" presence="required"/>
	</fixr:structure>
</fixr:message>
```

#### Scenarios

Message structures commonly vary with scenario or use case. For example,
an ExecutionReport might look quite different in its execution use case
versus a cancel-confirmation use case. The attribute that names a use
case is scenario. If no scenario is explicitly given, it defaults to
"base".

The combination of `id` and `scenario` attributes must be unique.

#### Responses

Aside from `<structure>`, `<message>` has another child element called
`<responses>`; it is explained in the section [Workflow](#workflow) below.

## Expressions

### Conditional expressions

Conditional expressions are rules that are expressed in a Domain Specific
Language (DSL). They are evaluated by substituting actual values from a
message and other state information for tokens in the expression. A
conditional expression is of Boolean type. That is, it evaluates true or
false. If true, it determines the value of another attribute or that
some action should take place, such as sending a certain response
message.

Conditional expressions are used in Orchestra:

  - To tell when a conditionally required field is required
    (presence=required);

  - To tell when a field attribute aside from `presence` is overridden,
    such as setting the range of valid values with `minInclusive` and
    `maxInclusive` attributes. It can even tell when to override the `type`
    of a field. For example, the `type` of SecurityID(48) could be overridden,
    depending on the value of SecurityIDSource(22). Some kinds of SecurityID(48) values are strings while others are numeric;

  - To tell when a specific workflow response should be sent or other
    action taken.

All conditions are declared in the XML content of a `<when>` element.
See the section [Score DSL](#score-dsl) below for details of the grammar.

### Assignment expressions

Assignment expressions are used to set the value of a field in an
outgoing message or to alter a state variable that belongs to an actor.
The grammar of assignment expressions is also governed by the [Score DSL](#score-dsl).

#### Assigning a field

To assign a field in an outgoing message, an `<assign>` element is
placed within the context of a `<fieldRef>` in the message structure.
The content of the `<assign>` element (text node) contains a Score
expression giving the value to set. The value must evaluate to a
datatype compatible with the type of the field.

**Example:** Echo the value of a field from an incoming message.

```xml
<fixr:fieldRef id="11" added="FIX.2.7" updated="FIX.5.0SP2" updatedEP="188">
	<fixr:assign>in.ClOrdID</fixr:assign>
</fixr:fieldRef>
```

#### Assigning repeating group entries

Within the context of a `<groupRef>`, one or more `<blockAssignment>`
elements may be used to specify the assignment of fields in entries of a
repeating group. Each instance of `<blockAssignment>` will cause another
entry to be constructed. Within a `<blockAssignment>`, the syntax for
assigning fields is the same as the assignment of an individual field
shown above.

**Example:** Assignment of two entries in the Parties repeating group.

```xml
<fixr:groupRef id="1012" added="FIX.4.3" updated="FIX.5.0SP2"
updatedEP="188">
	<fixr:blockAssignment>
		<fixr:fieldRef id="448">
			<fixr:assign>"ABC"</fixr:assign>
		</fixr:fieldRef>
		<fixr:fieldRef id="447" >
			<fixr:assign>^GeneralIdentifier</fixr:assign>
		</fixr:fieldRef>
		<fixr:fieldRef id="452">
			<fixr:assign>^ExecutingFirm</fixr:assign>
		</fixr:fieldRef>
	</fixr:blockAssignment>
	<fixr:blockAssignment>
		<fixr:fieldRef id="448">
			<fixr:assign>"DEF"</fixr:assign>
		</fixr:fieldRef>
		<fixr:fieldRef id="447">
			<fixr:assign>^GeneralIdentifier</fixr:assign>
		</fixr:fieldRef>
		<fixr:fieldRef id="452">
			<fixr:assign>^ClearingFirm</fixr:assign>
		</fixr:fieldRef>
	</fixr:blockAssignment>
</fixr:groupRef>
```

#### Assigning a state variable

To assign the value of a state variable when an event occurs, use the
`<assign>` element within a response. The expression contained by the
element must refer to a state variable contained by an actor. See the
section [Responses](#responses) below.

### Field attribute rules

Optionally, a `<rule>` element may be added as a child to `<fieldRef>`
to control an attribute of a field dynamically. Multiple rules are
allowed for the same field reference to affect multiple attributes or to
generate different values of an attribute under different conditions.

The attributes of a `<fieldRef>` that can be controlled by a rule
include type and any member of the fieldAttribGrp attribute group. That
group includes the `presence` attribute and attributes to control the length of a field.
A rule about presence tells when a conditionally required field is
required.

### Field validation rules

Orchestra has several ways to specify when a field value is valid. One
is to set a field’s type to a code set that lists all valid values.
Another is to set a valid range using attributes `minInclusive` and
`maxInclusive`.

More complex rules can be written under a `<fieldRef>` that reference
the values of other fields or the state variables of actors. Rules can
be dynamic. For example, a market might reject orders with limit
price outside a band of some differential above or below the last sale
price.

Rule violations can then be captured by a state variable, and if
appropriate, an action can be taken, such as sending a reject message.
It is important, particularly when generating test systems, to capture
all violations rather than reacting to the first one encountered. It is
recommended to capture all violations in a repeating group variable of
an `<actor>` element. Responses can be defined in the actor to perform
actions such as sending a reject message for certain kinds of
violations.

**Example:** A field validation rule sets a state variable when tripped.

```xml
<fixr:fieldRef id="44">
	<fixr:rule name="tick" >
		<fixr:assign>$validator.ViolationGrp[].ruleViolated="tick"</fixr:assign>
    <!-- price not even tick increment of .05 -->
	<fixr:when>(Price * 100) % 5 != 0</fixr:when>
	</fixr:rule>
</fixr:fieldRef>
```
\
**Example:** A state variable to hold rule violations.

```xml
<fixr:actor name="validator">
	<fixr:group id="10000" name="ViolationGrp">
		<fixr:numInGroup id="10001"/>
		<fixr:field id="10002" name="ruleViolated" type="String">
	</fixr:group>
</fixr:actor>
```

### Response conditions

A `<when>` element with a conditional expression is also supported in the
`<message>/<responses>` element tree. See section [Workflow](#workflow) below for usage.

## Workflow

Workflow is the behavior of a FIX party with respect to the exchange of
messages. For each received message type, one or more possible actions
can be specified under the `<message>/<responses>` element.

Workflow in Orchestra recognizes that there is not always a 1:1
relationship between a FIX MsgType(35) and a use case. Some FIX message
types such as ExecutionReport(35=8) are overloaded for many different
use cases. Therefore, messages in Orchestra are identified primarily by
their FIX MsgType(35) value, but with a qualification for a specific use case. Each message use case is called a scenario.

Behavior may depend upon more information than a receive message itself.
External state information enters it as well, e.g. the state of an order
book. The `<actors>` element tree provides a place to store such
external state information. An actor can also be used to identify the
originator or receiver of a message.

### Scenarios

A scenario is one use case of a specific message type, as identified by
key attributes `name` and `msgType` in the `messageAttribGrp` attribute group
supported by `<message>`. A scenario name is stored in the `scenario`
attribute of `<message>`. If there is only one use case for a message
type, then scenario need not be populated. It defaults to "base".
Scenarios must be unique per message type and it is an error to have
more than one `<message>` element of the same type without a scenario
since they would in effect be duplicates of scenario "base".

This standard imposes no naming convention for scenarios. Implementers
are free to choose names that are meaningful in their business.

Each scenario is represented by a `<message>` element, and thus has its
own message contents in its `<structure>` child element and its own
`<responses>` element tree.

#### Mapping a message to a scenario

*This section is non-normative.*

The task of mapping an actual received message to a scenario declaration
in Orchestra is left to implementations. The first level of matching is
on the `msgType` attribute. However, that message type may have
several scenarios. Pattern matching strategies might include comparing a
message to expected required fields, mapping values of a distinguishing
field like ExecType(150) to its code set literals, and so forth.

### Actors

An `<actor>` element represents either a counterparty to a FIX session
or an external entity that holds state relevant to application and
session behavior. An actor can take actions such as assigning state or
transitioning a state machine. If it represents a session counterparty,
it can send FIX messages. Also, actions can be time dependent. An
Orchestra file may declare any number of actors within the `<actors>`
parent element. The `name` attribute of an `<actor>` element must be
unique within an Orchestra file.

#### State variables

Actors can hold state variables in the form of FIX fields. That is, each
state variable has an id and name for identification and a value of a
FIX datatype. Like any field, valid values can be constrained to a code
set or range. The datatype or code set is declared in the `type`
attribute, just like any field.

If a state variable corresponds to a standard FIX field, it can be
declared as a `<fieldRef>` element child of the `<actor>`.
Alternatively, it can be declared in-line as a `<field>` element.
Additionally, state variables can be organized as components or
repeating groups.

A state variable can be tested in a conditional expression or set by an
assignment expression.

**Example:** An actor with state variables for TradingSession(336) and TradeDate(75).

```xml
<fixr:actor name="Market">
	<fixr:fieldRef id="336"/>
	<fixr:fieldRef id="75"/>
</fixr:actor>
```

#### State machines

A state machine has discrete values called states and defined
transitions between states. A state machine is declared in XML as a
`<states>` child element of an `<actor>`. The `<states>` element
contains any number `<state>` children, and one initial state of the
state machine, as `<initial>` element. It is an error to declare more
than one initial state. Some state changes are allowed and others
disallowed; changes can only be made through explicitly declared
transitions. A `<transition>` child of a `<state>` or `<initial>` gives
the name of the new state of the state machine in its `target` attribute.

States and transitions must have unique names within a state machine.

The current state of a state machine can be tested by a conditional
expression and a transition can be invoked by an assignment expression.

**Example:** A state machine for market phases.

```xml
<fixr:states name="Phase">
	<fixr:initial name="Closed">
		<fixr:transition name="Reopening" target="Preopen"/>
	</fixr:initial>
	<fixr:state name="Halted">
		<fixr:transition name="Resumed" target="Preopen"/>
	</fixr:state>
	<fixr:state name="Open">
		<fixr:transition name="Closing" target="Preclose"/>
	</fixr:state>
	<fixr:state name="Preopen">
		<fixr:transition name="Opened" target="Open"/>
	</fixr:state>
	<fixr:state name="Preclose">
		<fixr:transition name="Closed" target="Closed"/>
	</fixr:state>
</fixr:states>
```

#### Timers

Some application layer and session layer behaviors are time dependent. An event can fire when a timer expires to affect other states or send a message.

Like a state machine, a `<timer>` is the child of an `<actor>`, and it has a `name` attribute.

**Example:** A timer declaration
```xml
<fixr:timer name="expirationTimer"/>
```
\
**Example:** A timer operation to start a timer that triggers a transition in a state machine. Other events could cancel the timer.
```xml
<fixr:timerSchedule actor="Market" name="expirationTimer" operation="START">
	<fixr:activity>
		<fixr:trigger stateMachine="OrderState" actor="Market" name="Expired"/>
	</fixr:activity>
</fixr:timerSchedule>
```

### Flows

A `<flow>` element represents a stream of messages from one actor
(source) to another (destination). A flow depends on abstractions of the
session and transport layers, but is an application-layer view of
message exchange behavior. It is intended to be session and transport
protocol independent. Multiple application flows may be multiplexed in a
FIX session.

A `<flow>` is identified by its `name` attribute. It must have a `source`
and a `destination` attribute, and both of those must match the `name` of an
`<actor>` element. The `messageCast` attribute defaults to unicast, but
may be set to multicast.

The optional `reliability` attribute describes the delivery guarantee of
messages on the flow. It takes one of these values:

  - **bestEffort**—no delivery guarantee

  - **idempotent**—deliver at-most once

  - **recoverable**—deliver exactly once

**Example:** Actors and flows.

```xml
<fixr:actors>
	<fixr:actor name="BuySide"/>
	<fixr:actor name="SellSide"/>
	<fixr:flow name="OrderEntry" source="BuySide" destination="SellSide"
messageCast="unicast" reliability="idempotent"/>
	<fixr:flow name="Executions" source="SellSide" destination="BuySide"
messageCast="unicast" reliability="recoverable"/>
	<fixr:flow name="MarketData" source="SellSide" destination="BuySide"
messageCast="multicast" reliability="bestEffort"/>
</fixr:actors>
```

### Responses

Responses to a received message can be of these types:

  - A message is sent in reply to the received message

  - A state variable is changed

  - A state machine transition is invoked

  - A timer is started or canceled

Multiple responses can be specified for a given message scenario as
children of its `<responses>` element.

A `<when>` element supplies a conditional expression that triggers a
response if the condition is true. The expression is in the Score DSL
grammar (see section [Score DSL](#score-dsl) below). It is possible to trigger multiple
responses if more than one conditional expression evaluates true. If no
`<when>` element is provided for a `<response>`, then the response is
unconditional.

#### Message response

A `<messageRef>` child of a response represents a reply to the received
message. Its name, `msgType` and `scenario` attributes are the combined key
to a matching `<message>` to send.

An optional `<identifiers>` element contains one or more correlations
between a message and its response message. This information supports
the following relationships between chains of messages, such as between an
order and its executions. Each child `<correlate>` element supplies the
id of a field that is common to a message and its response. By default,
a common identifier is assumed to be in the same field in the message
and its response. If it is in different fields, then the `id` attribute
applies to the response message and sourceId applies to original
message. Also, it is possible to assign new identifiers in the response
message. The element `<assign>` is used to describe that case.

**Example:** Send a response message and show correlated and new identifiers.

```xml
<fixr:response name="orderAck">
	<fixr:messageRef name="ExecutionReport" msgType="8" implMaxOccurs="1"
id="9" scenario="base" implMinOccurs="1">
		<fixr:identifiers>
			<fixr:correlate id="11"/>
			<fixr:correlate id="2422"/>
			<fixr:assign id="37"/>
			<fixr:annotation>
				<fixr:documentation>
				ExecutionReport(35=8) echoes ClOrdId(11) and OrderRequestID(2422) from order message and assigns OrderID(37).
				</fixr:documentation>
			</fixr:annotation>
		</fixr:identifiers>
	</fixr:messageRef>
	<fixr:when>$Market.SecMassStatGrp[SecurityID==in.SecurityID].SecurityTradingStatus != ^TradingHalt and $Market.Phase == "Open"</fixr:when>
</fixr:response>
```

#### State variable response

An `<assign>` element changes the value of a state variable belonging to
an actor. Its child element `<assign>` references one or more state
variables to change in the form of an assignment expression.

**Example:** Assign a state variable belonging to actor "participant".

```xml
<fixr:assign>$participant.RiskLimitAmount=15000</fixr:assign>
```

#### State machine response

A `<trigger>` element represents a state machine transition, invoked
when a message is received. Its statemachine attribute identifies the
name of the state machine, and its `name` attribute refers to the name of a
`<transition>` within that state machine.

**Example:** Invoking a state machine transition: the market resumes after a halt.

```xml
<fixr:transitionRef actor="Market" stateMachine="Phase" name="Resumed"/>
```

#### Timer operation response

A `<timerSchedule>` element invokes an operation to either start or
cancel a timer. The `name` attribute refers to the name of the timer,
the operation tells whether to start or cancel, and interval gives the
elapsed time. Interval is expressed in the lexical space of XML schema
type duration. That type includes the magnitude and time unit of the
period in conformance to standard [ISO 8601:2019](https://www.iso.org/standard/70907.html). The `<responses>` elements
represents actions to take when the timer expires. Actions can include
sending a message, setting a state variable, or invoking a state machine
transition.

**Example:** Start a timer for 120 seconds. On timer expiration, send a cancel message, provided the order is still open.

```xml
<fixr:timerSchedule actor="trader" name="exposureTimer"
operation="START" interval="PT120S">
	<fixr:responses>
		<fixr:response>
			<fixr:messageRef name="OrderCancelRequest" msgType="F">
		</fixr:response>
	<fixr:responses>
</fixr:timerSchedule>
```

## Semantic Concepts

Optionally, semantic concepts may be identified by name, even when the
representation of such a concept changes across versions of a protocol.
Anchoring a changing representation to a stable concept can be used to inform
applications such as message translators.

A concept may be tied to a field or group of fields. Values may be variable
or constant. Also, a concept name may be used to link a generic event to
its message type and scenario.

Recognized concept names will be published by the FIX Trading Community. To
maximize portability, users should conform to those names.

**Example:** The semantic concept is stable, but the FIX 4.2 fields were replaced.

FIX 4.2 encoding

```xml
<fixr:concept name="ProgramOrder">
	<fixr:fieldRef id="47" presence="constant" value="D"/>
</fixr:concept>
```
\
FIX 4.4 encoding

```xml
<fixr:concept name="ProgramOrder">
	<fixr:fieldRef id="528" presence="constant" value="P"/>
	<fixr:fieldRef id="529" presence="constant" value="1"/>
</fixr:concept>
```
\
**Example:** The name of a message changed.

FIX 4.2 encoding

```xml
<fixr:concept name="BaseOrder">
	<fixr:messageRef name="OrderSingle" msgType="D" scenario="base"/>
</fixr:concept>
```
\
FIX 4.4 encoding

```xml
<fixr:concept name="BaseOrder">
	<fixr:messageRef name="NewOrderSingle" msgType="D" scenario="base"/>
</fixr:concept>
```

# Interfaces XML Schema

## XML Schema (XSD)

The FIXInterfaces schema represents service offering and session
provisioning. Its XML namespace is "http://fixprotocol.io/2020/orchestra/interfaces".

### Conformance

All published Interface files **must** conform to the standard XML
schema. This can be validated with common XML parsers and related tools.

### Schema location

The XML schema is currently available in GitHub project fix-orchestra module
[interfaces](https://github.com/FIXTradingCommunity/fix-orchestra/tree/master/interfaces).
Upon promotion to draft standard, it will be made available at a URI
consistent with its XML namespace.

### Root element

The root element an Interfaces XML file is `<interfaces>`. This snippet
shows that element with required namespaces:

```xml
<fixi:interfaces xmlns:dcterms="http://purl.org/dc/terms/"
xmlns:fixi="http://fixprotocol.io/2020/orchestra/interfaces"
xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xsi:schemaLocation="http://fixprotocol.io/2020/orchestra/interfaces FixInterfaces2020.xsd">
```

### Supplementary documentation

See the separate document “FixInterfaces2020.html” for a detailed
technical reference for the Interfaces XML schema. The remainder of this
section serves as an overview and explains motivations for the design.

### Protocol relationship

The schema was primarily designed to describe metadata about FIX
protocols. However, it was also intended to be generic enough to work
with other common financial industry protocols, especially when FIX is
used in combination with other protocols.

### Extensibility

This schema was designed to maximize extensibility so that it represents
a wide range of applications, even with non-FIX protocols. Most elements
allow the addition of attributes and types allow additional child elements,
possibly conformant to other XML schemas.

### Provenance

The `<metadata>` element is used to identify a particular Interfaces
file and the issuer of that file. It can contain any of the elements
defined by the Dublin Core XML schema. Recommended elements include
publisher, date, and rights.

### Session effective times

Optionally, a session may be configured for start and end time. Adding a
session prior to its effective time allows configuration tasks to be
carried out in advance of usage.

### Incremental changes

The Interface file format represents current state. Aside from session
effective times, it does not carry full pedigree. However, if a party
wishes to represent incremental changes to a file, it may do so using
XML patch operations as specified in IETF RFC 5261.

### Interface

The root element `<interfaces>` contains one or more `<interface>`
elements. An interface is a collection of protocols and services exposed
by a counterparty. An interface may be configured for one or more
service offerings and all the protocols that make up a communication
stack. A service offering is exposed as a `<service>` element, and
protocols are given as elements for each layer of a stack. Also, an
interface may contain any number of session configurations under its
child `<sessions>` element. An `<interface>` element has a `name`
attribute.

### Protocols

An `<interface>` element has children for each layer of a protocol
stack. The children are `<userInterface>`, `<encoding>`,
`<sessionProtocol>`, `<transport>`, and `<protocol>`. An `<interface>`
may have multiple instances of a protocol. For example, a session may
use primary and secondary transports.

Any message-oriented protocol may have an `orchestration` attribute that
consists of a URI. It is a link to an Orchestra file that describes
message structures and workflow. A URI may link to a web resource or a
local file.

All the protocol elements have `name` and `version` attributes.

### Service

A service is an application layer protocol. The `<service>` element is
of XML protocolType, carrying the same attributes as other protocols.

### Transport

The `<transport>` element is derived from XML protocolType but has
additional attributes address, messageCast and use. The optional
`messageCast` attribute has an enumeration of values: unicast, multicast
and broadcast. The optional `use` attribute can have values primary,
secondary and alternate.

### Session

A `<session>` inherits services and protocols from its parent
`<interface>`, but it may have further refinement or overrides of
protocol settings, such as a transport address.

A session has one or more identifiers in child `<identifier>` elements.
The `<value>` child of `<identifier>` may be of any XML type, even an
element tree.

#### Security keys

Security keys may be conveyed for a session in its child `<securityKeys>` element. The content of that element must conform to textual encoding as specified by IETF RFC 7468.

# Score DSL

## Grammar

### Comments

Comments may be inserted in Score expressions in two forms. Comments are
ignored by an expression evaluator but give a humanly readable
explanation.

#### C-language style comments

C-language style comments are contained by tokens /\* and \*/.

**Example:** /\* This is a C style comment. \*/

#### Line comments

Line comments extend from the token // to the next line break.

**Example:** // This is a line comment.

### Literals

A literal stands for a value that is assignable to a FIX datatype.

#### Character literal

A character literal is of FIX datatype char. It is delimited by single
quotes.

**Example:** ′a′

#### String literal

A character literal is of FIX datatype String. It is delimited by double
quotes.

**Example:** "A String literal"

#### Integer literal

An integer literal is of FIX datatype int. It is a sequence of digits and may be preceded by a hyphen character that represents
the unary minus operator.

**Examples:** "123", "-123"

#### Decimal literal

A decimal literal is assignable to FIX datatypes float, Price, Amt, Qty,
PriceOffset or Percentage. It is a sequence of digits followed by a
decimal point (period character) and another sequence of digits. At
least one digit must precede and follow the decimal point. A decimal
literal may be preceded by a unary minus operator (hyphen character).

**Example:** "123.456"

#### Date-time literals

Date, time of day, and date-time literals are delimited by the \#
character. The syntax within the delimiters is governed by the standard
[ISO 8601:2019](https://www.iso.org/standard/70907.html) "Date and time format".

##### Date literal

A date literal is of the form YYYY-MM-DD with a hyphen character
separating the year, month and day parts. A date literal is of FIX
datatype UTCDateOnly.

**Example:** \#2017-03-21\#

##### Time literal

A time of day literal is of the form HH:MM:SS.FFFFFFFFFTZD with a colon
character separating the hour, minute and optional second parts. An
optional fraction of a second follows a decimal point (period
character). It may represent nanosecond precision. Finally, a time
literal contains a timezone designator, either the literal Z, or a
timezone offset from UTC. A timezone offset is of the form \[+|-\]HH:MM.
It represents an offset from UTC in hours and minutes. A time literal is
of FIX datatype UTCTimeOnly.

**Examples:**

\#09:58:24.123456789Z\#

\#09:58:24Z\#

\#09:58-06:00\#

##### Date-time literal

A time of day literal is of the form YYYY-MM-DD THH:MM:SS.FFFFFFFFFTZD.
The syntax of the parts are the same as a date literal followed by a
time literal. A date-time literal is of FIX datatype UTCTimestamp.

**Examples:**

\#2017-03-21T09:58:24.123456789Z\#

\#2017-03-21T09:58:24Z\#

\#2017-03-21T09:58-06:00\#

##### Duration literal

A duration literal is of the form PYMWDTHMS. In all cases, ‘P’ is a
prefix, and ‘T’ separates date units from time of day units. The units
of time are represented by literal Y=year, M=month, W=week, D=day,
H=hour, M=minute, S=second. Each unit is optional, but they may be used
in any combination.

Currently, there is no FIX datatype that represents duration, but a
duration literal may be used with date and time literals in date and
time expressions in the DSL.

**Examples:**

7 days: \#P7D\#

1 hour 30 minutes: \#PT1H30M\#

10 seconds: \#PT10S\#

N.B. Month duration is recognized by the [ISO 8601:2019](https://www.iso.org/standard/70907.html) syntax, but since
months are of different numbers of days, the resulting duration is
indeterminate without some context about how to count days.

#### Code literal

A code of a code set is designated by its name preceded by the ^
character. The code set that contains the code is generally inferred by
a field scope within an expression.

**Example:** Code literal for OrdType(40)=3 is ^StopLimit.

### Variables

A variable is a named value that is independent of sent and received
messages. A variable has a name and a value of any FIX datatype. A state
variable is created and populated by an assignment expression (see
below). The datatype of a state variable is set by the assignment.

#### Variable names

The following entities must have distinct names to be used in
conditional or assignment expressions.

  - A field used as a state variable of an actor.

  - The current state of a state machine, belonging to an actor.

  - A timer that belongs to an actor.

Variable names are always prefixed by the character $. Any meaningful
name may be used; there is no need to conform to FIX message element
names. All names must begin with a letter, and the rest of the name may
contain upper or lower case letters, digits, or the underscore
character. A name may consist of multiple qualifiers, each separated by
a dot (period character). The first qualifier should correspond to an
actor name. Variables may be grouped within actor context by further
qualifiers.

**Example:** $myactor.totalQty

### Message element references

The DSL syntax allows access to fields in received messages and
population of field in messages to be sent.

#### Field names

The following entities must have distinct names to be used in
conditional or assignment expressions.

  - A field at the root level of a message

  - A field contained by a repeating group. In the case of a repeating
    group, an entry is indexed or an entry may be selected by a
    conditional expression (see below).

The high-level qualifier for a received message is "in", and the
high-level qualifier for an outbound message is "out". In implementations,
the scope of a message may be implicit, making the high-level qualifier
unnecessary. Then a field can simply be referenced by name. However,
qualification is needed if for example, an expression about a field in
an outgoing response message refers to a field in its inbound request.

#### Repeating group entry selection

If a field is within a repeating group, then an entry in the group must
be selected to retrieve the value of the field. This can be done in two
ways. The first way is by using a one-based index (ordinal number) to
select an entry. The index is surrounded by square brackets. The
repeating group and field names are separated by a dot (period
character).

**Example:** Reference MDEntryType(269) field in the second entry of its
repeating group: MDIncGrp\[2\].MDEntryType.

The second method of accessing a repeating group entry is by using an
equality expression using a second field in the group as a key. The
expression is placed in square brackets. The condition selects a
repeating group entry by testing equality of a named field in the group
entry to a literal value.

**Example:** References PartyID(448) field in the repeating group entry for which
PartyRole(452) = 4 (Clearing Firm): Parties\[PartyRole==4\].PartyID

Alternatively, the same field can be accessed by using a code literal in
the equality expression.

**Example:** Reference field in the repeating group entry for which
PartyRole(452) = 4 (Clearing Firm): Parties\[PartyRole==^ClearingFirm\].PartyID

### Conditional expressions

Conditional expressions are used for multiple purposes in Orchestra:

  - To tell when a conditionally required field is in fact required;

  - To tell when a certain response to a received message is triggered;

  - To select an entry in a repeating group using a field value, as
    described above.

Conditional expressions take several forms:

  - Relational expression: Compare a field’s value in a received message
    to a literal of the field’s datatype or a code designated by its
    name in a code set associated to the field.

  - Relational expression: Compare a field’s value in a received message
    to the value of another field in the same message or to a field used
    as a state variable belonging to an actor.

  - Relational expression: Compare the current state of a state machine
    to a literal representing one of its possible states.

  - Compound relational conditions joined by "and" and "or".

  - Relational expressions may express set inclusion or data range
    inclusion.

  - Relational expressions may depend on simple expressions that use
    arithmetic operators on terms.

#### Relational operators

These are the relational operators of the Scope grammar. Operands must
be of the same or compatible datatypes.

| Token     | Name                  |
| --------- | --------------------- |
| \< or lt  | less than             |
| \<= or le | less than or equal    |
| \> or gt  | greater than          |
| \>= or ge | greater than or equal |

#### Equality operators

These are the equality operators of the Scope grammar. Operands must be
of the same or compatible datatypes.

| Token     | Name       |
| --------- | ---------- |
| \== or eq | equals     |
| \!= or ne | not equals |

#### Logical operators

These are the logical operators of the Scope grammar. Operands must be
Boolean.

| Token     | Name |
| --------- | ---- |
| && or and | and  |
| &#124;&#124; or or  | or   |

#### Arithmetic operators

These are the arithmetic operators of the Scope grammar. Operands must
be numeric. Multiplication and division have higher priority than
addition and subtraction when not grouped by parentheses.

| Token    | Name           |
| -------- | -------------- |
| \*       | multiplication |
| /        | division       |
| % or mod | modulo         |
| \+       | addition       |
| \-       | subtraction    |

#### Unary operators

These are the unary operators of the Scope grammar.

| Token | Name        | Operand type |
| ----- | ----------- | ------------ |
| \-    | minus       | numeric      |
| \!    | logical not | Boolean      |

#### Parentheses

Terms of an expression may be grouped by parentheses to override the
default operator precedence. Opening and closing parentheses must always
match.

#### Set operator

The set operator tests whether a value is in a set of values of the same
datatype. The result of the operation is Boolean. The syntax is as
follows:

value in {member, member …}

Value may be a literal, state variable or reference to a message field.
Each member may be a literal or other expression of the same datatype.

#### Range operator

The range operator tests whether a value is in a range of values of the
same datatype. The result of the operation is Boolean. The syntax is as
follows:

value between min and max

The range operator is a shortcut for value \<= min and value \>= max.
Value may be a literal, state variable or reference to a message field.
Min and max may be a literal or other expression of the same datatype.

#### Existence operator

The existence operator tests whether a variable has been defined, or if
an element is present in a message. The test is of Boolean type and may
be combined with other logical operators to form a conditional
expression. The syntax is of the form:

exists variable/element

### Assignment expressions

The following entities may be assigned values in an expression:

  - A field of a message to be sent in a scenario.

  - A field used as a state variable of an actor.

The assignment operator is the = character. The left-hand operand must
be either a state variable or a mutable message field. Literals are
immutable so a literal cannot be the lvalue (left-hand operand) of an assignment expression.
The right-hand operand can be any expression of a compatible datatype.
In the case of a variable, it takes the datatype of the expression if it
has never been assigned before.

## Syntax errors

Implementations should throw an exception if a DSL expression does not
follow the syntax described above. For example, parentheses are
mismatched.

## Semantic errors

Implementations should throw an exception in these cases:

  - Operands are of incompatible datatypes. For example, a relational
    operator is asked to compare a price value to a UTC timestamp.

  - A variable or message element referenced by an expression does not
    exist.

# Examples

Example Orchestra files are provided in the GitHub project
[FIXTradingCommunity/fix-orchestra](https://github.com/FIXTradingCommunity/fix-orchestra).

# Appendix

## Changes from Repository 2010 Edition

  - New features: metadata with provenance, actors, workflow, semantic
    concepts.

  - An Orchestra file supports a single protocol version. If an
    organization supports multiple protocols, it should issue an
    Orchestra file for each.

  - The codeSets element is now top-level while in the 2010 Edition,
    enumerations of valid values were contained by fields. This change
    was made to recognize that code sets may be shared by many fields
    and also, they may be managed by an external standard.

  - The datatype element was enhanced to support mapping FIX datatypes
    to any other type system, and not just XML schema datatypes.

  - The Orchestra schema provides a feature to explicitly link a field,
    called a discriminator, that modifies the value space of another
    field.

  - Repeating groups were moved to their own parent element from other components.

  - Scenarios overload the layout of a message or component for
    different use cases.

  - The interfaces schema is new.

## Compliance

To be useful, various implementations of FIX Orchestra must
interoperate. The FIX Trading Community discourages implementations that
deviate from this specification while promoting those that are
compliant.

At minimum, a compliant application:

  - Must conform to the XML schemas published in the GitHub fix-orchestra
    project.

  - Must conform to the DSL grammar published in the GitHub project.

Additional compliance utilities may be published. Only applications that
pass these checks will qualify for endorsement.
