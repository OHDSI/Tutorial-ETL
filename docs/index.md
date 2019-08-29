---
layout: default
title: Home
nav_order: 1
description: "This document is meant to describe the ETL process for the synthea dataset"

---

# Synthea ETL Documentation

This guide is meant to show the process by which the synthetic data set [Synthea](https://synthetichealth.github.io/synthea/) was converted to the [OMOP Common Data Model](https://github.com/OHDSI/CommonDataModel) for the purposes of this tutorial. The SyntheticHealth team is continually adding new tables to Synthea, however, we chose to map the following: 

* [Patients](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#patients)
* [Encounters](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#encounters)
* [Conditions](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#conditions)
* [Medications](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#medications)
* [Observations](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#observations)
* [Procedures](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#procedures)
* [Allergies](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#allergies)
* [Immunizations](https://github.com/OHDSI/Tutorial-ETL/wiki/Data-Dictionary#immunizations)

The below image illustrates how each Synthea table was mapped to its corresponding OMOP CDM table(s). Some of the native tables were mapped to more than one CDM table and that is largely due to vocabulary and domain movement. 

![](syntheaETL_files/image1.png) 
