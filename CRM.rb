#load 'contact.rb'
require_relative 'contact.rb'
require_relative 'rolodex.rb'

class CRM # view

  def self.run
    my_crm = new
    my_crm.main_menu
  end

  def initialize
    @rolodex = Rolodex.new
    @rolodex.add_contact(Contact.new("Bob", "Jones", "bobjones@ocp.com", "Vice President"))
  end

  def print_main_menu
    puts "Welcome to CRM Database Manager 1.0"
    puts "Please select one of the following options:"
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display a contact"
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

  def add_new_contact #1
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

  def modify_contact #2
    print "Enter the ID of the user you would like to modify: "
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact.to_s
    print "Is this the correct contact (y/n)? "
    user_choice = gets.chomp
    if user_choice.downcase == "y"
      puts "What would you like to change?"
      puts "[1] First Name"
      puts "[2] Last Name"
      puts "[3] E-Mail"
      puts "[4] Notes"
      print "Enter your selection: "
      user_option = gets.chomp.to_i
      if user_option == 1
        puts "Enter the first name: "
        contact.first_name = gets.chomp
      elsif user_option == 2
        puts "Enter the last name: "
        contact.last_name = gets.chomp
      elsif user_option == 3
        puts "Enter the E-Mail: "
        contact.email = gets.chomp
      elsif user_option == 4
        puts "Enter the Notes: "
        contact.note = gets.chomp
      end
    elsif user_choice.downcase == "n"
        main_menu

    end 

  end

  def delete_contact #3
    print "Enter the ID of the user you would like to delete: "
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
    print "Is this the correct contact (y/n)? "
    user_choice = gets.chomp
    if user_choice.downcase == "y"
      @rolodex.delete_contact(contact)
      puts "The user has been deleted"
    else
      main_menu
    end
  end

  def display_contact #4
    print "Enter the ID of the user you would like to find: "
    contact_id = gets.chomp.to_i
    contact = @rolodex.find(contact_id)
    puts contact
    main_menu
  end

  def display_by_attribute
    puts "What would you like to display by?"
    puts "[1] First Name"
    puts "[2] Last Name"
    puts "[3] E-Mail"
    puts "[4] Notes"
    user_choice = gets.chomp.to_i

    @rolodex.contacts.each do |contact|
      case user_choice
      when 1
        puts "First Name: #{contact.first_name}"
      when 2
        puts "Last Name: #{contact.last_name}"
      when 3
        puts "E-Mail: #{contact.email}"
      when 4
        puts "First Name: #{contact.note}"
      end
    end

    main_menu
  end
end

my_crm = CRM.new
my_crm.main_menu
