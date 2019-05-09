# Make contact list -- loop until exit

# create menu with the following
  #create contact
  #view all contacts
  #delete contact
  #edit contact
  #exit

    @contact_list = [{first_name:"skip", last_name:"mangosteen", email:"skippymangosteen@hogwash.com"}]
    @first_run = true
 
  def main
      if @first_run
        system "clear"
        @first_run = false
      end

    puts "--- Ruby Contact List ---"
    puts "1 - Create Contact"
    puts "2 - View Contacts"
    puts "3 - Delete Contact"
    puts "4 - Edit Contact"
    puts "5 - Exit"
    puts "\n"
    puts "Please Make a Selection: "
    user_selection = gets.strip.to_i

  case user_selection
    when 1
      create_contact
    when 2
      view_contacts
    when 3
      delete_contact
    when 4
      edit_contact
    when 5
      quit
    else
      puts "Invalid Selection.  Please select an option from the menu. (ENTER to continue)"
      continue
  end

  ### CREATE CONTACT
  def create_contact
    system  "clear"
    puts "--- Create Contact ---"
    print "First Name: "

    first_name = gets.strip

    print "Last Name: "
    last_name = gets.strip

    print "Email Address: "
    email = gets.strip

    @contact_list.push({first_name: first_name, last_name: last_name, email: email})

    puts "Contact created! (ENTER to continue)"
    continue
  end

  ### VIEW CONTACTS
  def view_contacts
    system "clear"
    puts "--- View Contacts ---"
    getContacts
    puts "Please press ENTER to continue."
    continue  
  end

  ### DELETE CONTACT
  def delete_contact
    system "clear"
    puts "--- Delete Contact ---"

    #Handle Empty Contact List
    if @contact_list.length <= 0
      puts "No contacts to delete. (ENTER to continue)"
      continue
    end

    puts "Please select a contact to delete. \n"

    # show the current list the user can select from
    getContacts
    puts "0) to exit. \n"
    puts "Selection: "
    input = gets.strip.to_i

    # If the user selects exit return to the main menu
    if input == 0
      puts "Returning to main Menu. (ENTER to continue)"
      continue
    end

    contact = input - 1

    #save out the contact so we can refer back to it once it has been deleted
    old_contact = @contact_list[contact]
    puts "Are you sure you want to delete #{old_contact[:first_name]} [Y/N]? This process cannot be undone!"

    selection = gets.strip 
    if selection == "Y" || selection == "y"  
      @contact_list.delete_at(contact)
      puts "#{old_contact[:first_name]} deleted!"
      puts "Press ENTER to continue"
    else
      #rerun this method - puts the user back a the delete menu
      delete_contact
    end

    continue
  end

  ### EDIT CONTACT
  def edit_contact
    system "clear"
    puts "--- Edit Contact ---"
    
    getContacts
    puts "0) to exit. \n"
    puts "Please select a contact to edit. \n"



    input = gets.strip.to_i
    contact = input - 1
    old_contact = @contact_list[contact]
    new_contact = @contact_list[contact].clone

    if input == 0
      puts "Returning to main Menu. (ENTER to continue)"
      continue
    end

    system "clear"
    puts "--- Edit Contact ---"
    puts "1) First Name (#{old_contact[:first_name]})"
    puts "2) Last Name (#{old_contact[:last_name]})"
    puts "3) Email (#{old_contact[:email]})"
    print "\nWhich field would you like to edit? "
    user_selection = gets.strip.to_i
    case user_selection
    when 1 
      print "New First Name: "
      new_contact[:first_name] = gets.strip
    when 2
      print "New Last Name: "
      new_contact[:last_name] = gets.strip
    when 3
      print "New Email Address: "
      new_contact[:email] = gets.strip
    end

    system "clear"
    puts "Do you wish to replace\n #{old_contact[:first_name]} #{old_contact[:last_name]} #{old_contact[:email]}\n\n with\n\n #{new_contact[:first_name]} #{new_contact[:last_name]} #{new_contact[:email]}?"
    print "[Y/N]"
    selection = gets.strip
    if selection == "Y" || selection == "y"
      @contact_list[contact] = new_contact
      puts "Contact updated! (ENTER to continue)"
      continue
    else
      puts "Contact not edited. (ENTER to continue)"
      continue
    end

    main
  end

  ### QUIT
  def quit
    system "clear"
    exit
  end

  ### HELPER METHODS
  # prints a list of all contacts
  def getContacts
    @contact_list.each_with_index do |c, i|
      #puts "#{i +1}) #{c}"
      puts "#{i +1}) #{c[:first_name]} #{c[:last_name]} #{c[:email]}"
    end
  end

  # Pauses the program until user presses enter
  def continue
    if gets == "\n"
      system "clear"
      main
    end
  end
end

### Call the main loop
main

