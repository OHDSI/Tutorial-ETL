# Tutorial-ETL
Materials necessary for the "OMOP Common Data Model Extract, Transform & Load Tutorial".  The goal of this tutorial is to learn about best practices and OHDSI tools developed to help with designing an extract, transform, & load process to take your database from raw observational data to the OMOP Common Data Model.  Pre-requisite course would be the OMOP CDM & Vocabulary Tutorial or working experience with the OMOP CDM and OMOP Vocabulary.

## Pre-Reads
* [Lauren's Story (Endometriosis UK)](https://www.endometriosis-uk.org/laurens-story)
* [Synthea Data Dictionary](https://github.com/synthetichealth/synthea/wiki/CSV-File-Data-Dictionary)
* [ETL - Book of OHDSI](https://ohdsi.github.io/TheBookOfOhdsi/ExtractTransformLoad.html) (OPTIONAL)

## Materials for Students
* [PowerPoint](https://github.com/OHDSI/Tutorial-ETL/blob/master/materials/OMOP%20Common%20Data%20Model%20Extract%2C%20Transform%20%26%20Load.pptx)
* [Synthea ETL Document (for tutorial)](https://ohdsi.github.io/Tutorial-ETL/)

## Tutorial Materials
* [Synthea ETL](https://github.com/OHDSI/ETL-Synthea)
* [Synthea ETL Document (official)](https://ohdsi.github.io/ETL-Synthea/)

## AWS Setup
* [OHDSI-In-a-Box](https://github.com/OHDSI/OHDSI-in-a-Box)
* OHDSI Tools Required
	* [White Rabbit / Rabbit in a Hat](https://github.com/OHDSI/WhiteRabbit)
	* [USAGI](https://github.com/OHDSI/Usagi)
		* With indexes prebuilt ([documentation](https://ohdsi.github.io/TheBookOfOhdsi/ExtractTransformLoad.html#usagi))
	* Data
		* OMOP Vocabulary
		* Raw Synthea Data
		* CDM Synthea Data V1
		* CDM Synthea Data V2
		* Raw Lauren Data (empty, SQL generates data)
		* CDM Lauren Data
* R Studio, R, OHDSI R Packages
	* [DB Connector](https://github.com/OHDSI/DatabaseConnector)
	* [SQL Render](https://github.com/OHDSI/SqlRender)