# Case 1

[Intercontinental Exchange](https://www.nyse.com/) provides a chart with [Daily NYSE Group Volume in NYSE Listed, 2017](http://www.nyxdata.com/nysedata/asp/factbook/viewer_edition.asp?mode=table&key=3141&category=3).

We can fetch the Excel file which is actually a CSV file using tab as a separator, remove the headings and load it into a PostgreSQL table.

Figures in the raw data are with coma-separated thousands and dollar signs, so we can’t readily process the figures as numbers.

So we create an ad-hoc table definition, and once the data is loaded we then transform it into a proper SQL data type, thanks to alter table commands.

## Exercise 1: Load data from external data source

### Learned techniques
1. ```\copy``` psql meta-comand to stream data between client and server
1. ```ALTER col USING expr``` to simultaneously migrate table data while migrating table scheme
1. ```REPLACE(val, old, new)``` text function
1. ```SUBSTRING(val FROM idx)``` text function
1. ```val::DATATYPE``` explicit type annotation
1. ```E'\esc-seq'``` escape sequence character literal
