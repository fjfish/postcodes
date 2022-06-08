# Postcode Coding Test App

There is a gem for Postcodes IO, but the test implies you need to write something that talks to the API so we'll do that instead.

This app was written using Ruby 3.1.1 and Rails 7. Storage is using SqlLite, mainly so we don't have Docker or Postgres install hell.

## Tentative design

The requirement is to identify whether a postcode falls within a specific LSOA, which is an attribute of the postcode entry.

There are some exceptions to this

* Some are unknown to the API but may still be accepted
* Some need to be accepted anyway even if they fall outside

## Tentative Design

1. Screens and database for creating an LSOA
   1. Name
   2. Acceptable postcodes
   3. Strings to search for in LSOA description (compile to Regexp?)
2. Screen to do the query
   1. Pick your LSOA
   2. Give it a postcode
   3. Show check result

## Plan

* First we need to just get information from the postcode.io server and prove connectivity
* Create the CRUD for the LSOA and its postcodes
* Drill down into the logic for LSOA membership

## Testing strategy

For brevity cucumber-style testing and the full _inside out_ step generation will be avoided. Instead spec out the model and service classes and leave the controllers and views as close to the original scaffold as possible.

## Validation of postcodes

The API can validate postcodes, but we are allowed to accept ones that it can't find. Still feels useful though. See if we can find a way of incorporating it as a warning rather than an error.
