#!/usr/bin/env ruby
require 'spreadsheet'
 
# Begin Test
print "Spreadsheet Test\n"
 
# Create the rows to be inserted
row_1 = ['A1', 'B1']
row_2 = ['A2', 'B2']
 
# Create a new Workbook
new_book = Spreadsheet::Workbook.new
 
# Create the worksheet
new_book.create_worksheet :name => 'Sheet Name'
 
# Add row_1
new_book.worksheet(0).insert_row(0, row_1)
 
# Write the file
new_book.write('test.xls')
 
# Wait for the user to inspect the file manually
print "Sheet Created, press Enter to continue...."
gets
 
# Open the previously created Workbook
open_book = Spreadsheet.open('test.xls')
 
# Get the row index in order to append a new row 
# after any exisitng rows with data
new_row_index = open_book.worksheet(0).last_row_index + 1
 
# Indicate the row index to the user
print "Inserting new row at index: #{new_row_index}\n"
 
# Insert row_2
open_book.worksheet(0).insert_row(new_row_index, row_2)
 
# Delete the file so that it can be re-written
File.delete('test.xls')
 
# Write out the Workbook again
open_book.write('test.xls')
 
# End Test
print "Test Complete.\n"