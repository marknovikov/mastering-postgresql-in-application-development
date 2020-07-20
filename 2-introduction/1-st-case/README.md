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
1. ```val::DATATYPE``` explicit type annotation to interpret literal as a value of particular type in arbitrary expressions
1. ```E'\esc-seq'``` escape sequence literal

## Exercise 2: List the factbook entries for February

### Learned techniques
1. ```\set name value``` psql meta-comand to declare client-scoped variables
1. ```:'var'``` expression to resolve value of a variable previously declared with `\set var val`
1. ```TO_CHAR(val, 'FORMATTING_TEMPLATE')``` function to format arbitrary values to text representation according to a given template
1. ```'G'``` locale-dependent group separator formatting template pattern, like decimal numbers group separator, like ```'999G99'``` may be `1000,00` or `1000.00` depending on locale
1. ```'L'``` locale-dependent currency symbol formatting template pattern, like ```'L9999'``` may be `$1000`
1. ```INTERVAL``` data type, which is a postgres' type for `duration` values
1. ```DATATYPE expr``` decorated literal expression to interpret expression as a value of particular type in arbitrary expressions; particularly useful in time expressions like ```DATE '2017-02-01' + INTERVAL '1 month'```
1. first day of a month + 1 month yields the first day of the next month
1. ```dbname=db application_name=app``` connection string to open network connection to particular db on PostgreSQL server as a particular application
1. ```CAST(val AS DATATYPE)``` function to transform value to particular data type
1. ```COALESCE(val, ...)``` expression to select the first of the arguments that is not `NULL`
1. ```GENERATE_SERIES(start, end, step)``` set returning function to generate a series of values from start to end with a step size of step and return them as a anonymous table
1. ```GENERATE_SERIES()``` function and ```BETWEEN``` operator are inclusive, that is upper bound `end` is included in the result set
1. ```table_expr AS table(col, ...)```
1. SQL standard supports ```/* */``` C-style block comment syntax

### Open questions
1. What is the difference between ```val::DATATYPE``` and ```DATATYPE val``` explicit type decoration syntaxes? Seems to work 100% identical in my queries...
1. When to use `CAST(val AS TYPE)` vs type annotation vs type decoration?
1. Port python code to Go
1. Examine docs for Go PostgreSQL driver (in particular, how to send SQL query parameters separately from the main SQL query text)
1. Benchmark app code vs sql script
