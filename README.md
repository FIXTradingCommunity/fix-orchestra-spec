# FIX Orchestra Technical Specification
This project contains specifications for FIX Orchestra and FIX Repository 2016 Edition. Additional resources and sample
code is available in project [fix-orchestra](https://github.com/FIXTradingCommunity/fix-orchestra).

The purpose of FIX Orchestra is to support the exchange of machine readable rules of engagement between FIX counterparties.

### Planned Lifecycle

The planned lifecycle of this project is to roll out new features in a series of release candidates. After each release candidate is approved, it will be exposed to public review.  When version 1 is considered complete, the last release candidate will be promoted to Draft Standard.

### Participation

Issues may be entered here in GitHub or in a discussion forum on the [FIX Trading Community site](http://www.fixtradingcommunity.org/). In GitHub, anyone may enter issues or pull requests for the next release candidate. 

## Versions

### Current version: Release Candidate 4

Release Candidate 4 was approved by the Global Technical Committee on Feb. 21, 2019 for 90 day public review.  The key enhancements in Release Candidate 4 were:

* Scenarios were extended to fields and code sets.
* Components and repeating groups were separated in the XML schema.
* Identifiers were normalized and simplified.

### Release Candidate 3
Release Candidate 3 was approved by the Global Technical Committee on March 8, 2018 for 90 day public review. The key enhancements in Release Candidate 3 were:

* The XML schema was simplified to support a single protocol version per file.
* Scenarios were extended down to the component level as well as to messages. For example, different flavors of the Instrument block can be defined for different asset classes or for a full version versus a brief version.
* Discriminator fields that modify the data domain of another field, such as SecurityIDSource and SecurityID, are now machine readable.
* The schema now supports rendering hints to inform code generators and the like.
* Facilities were added to define stable semantic concepts for which encoding changed between versions of FIX. For example, the Rule80A field in FIX 4.2 was replaced by OrderCapacity and OrderRestrictions fields.


### Release Candidate 2
Release Candidate 2 was approved by the Global Technical Committee on May 18, 2017 for 90 day public review. The themes for Release Candidate 2 were:
* Completion of a DSL grammar for conditional expressions
* FIXatdl integration
* Session configuration

### Release Candidate 1
Version 1.0 RC1 standardized the XML schema for FIX Orchestra and FIX Repository 2016 Edition. Release Candidate 1 was approved by the Global Technical Committee on Dec. 15, 2016 for 90 day public review. 

## License
FIX Orchestra specifications are © Copyright 2016-2019 FIX Protocol Ltd. 

<a rel="license" href="http://creativecommons.org/licenses/by-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nd/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">FIX Orchestra Technical Specification</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="http://www.fixtradingcommunity.org/" property="cc:attributionName" rel="cc:attributionURL">FIX Protocol Ltd.</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nd/4.0/">Creative Commons Attribution-NoDerivatives 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/FIXTradingCommunity/fix-orchestra-spec" rel="dct:source">https://github.com/FIXTradingCommunity/fix-orchestra-spec</a>.

## Implementations
We will post links to implementations of FIX Orchestra. Implementors, contact one
of the owners of this repository.
