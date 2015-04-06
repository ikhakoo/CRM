#load 'contact.rb'
require_relative 'contact.rb'
require_relative 'rolodex.rb'

class CRM

  def self.run
    my_crm = new
    my_crm.main_menu
  end

  def initialize
    @rolodex = Rolodex.new
  end

  def print_main_menu
    puts "Welcome to CRM Database Manager 1.0"
    puts "Please select one of the following options:"
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute"
    puts "[6] Exit"
  end

  def call_selection(selection)
    add_new_contact if selection == 1
    modify_contact if selection == 2
    delete_contact if selection == 3
    display_contact if selection == 4
    display_by_attribute if selection == 5
    exit if selection == 6
  end

  def main_menu
    while true
      print_main_menu
      selection = gets.chomp.to_i
      call_selection(selection)
    end
  end

  def add_new_contact
    print "First Name: "
    first_name = gets.chomp
    print "Last Name: "
    last_name = gets.chomp
    print "Email: "
    email = gets.chomp
    print "Additional Notes: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    @rolodex.add_contact(contact)
    main_menu
  end 

  def display_contact
    print "Enter the ID of the user you would like to find: "
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact.to_s
    main_menu
  end
end

my_crm = CRM.new
my_crm.main_menu
