require "active_record"

class Todo < ActiveRecord::Base
  #Helps in Displaying everything according to the expected format.
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = (due_date == Date.today) ? nil : due_date
    "#{id}#{display_status} #{todo_text} #{display_date}"
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end
  def self.duetoday
    where(due_date: Date.today)
  end
  def self.duelater
    where("due_date > ?", Date.today)
  end
  #maps through the todos array and converts it into a multiline statement.
  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.show_list
    puts "My Todo-list\n\n"
    #Checks weather the duedate is overdue filters the statements in that date and displays it.
    puts "Overdue\n"
    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    #Checks whether the duedate is duetoday filters the statements in that date and displays it.
    puts "Due Today\n"
    puts duetoday.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    #Checks whether the duedate is duelater filters the statements in that date and displays it.
    puts "Due Later\n"
    puts duelater.map { |todo| todo.to_displayable_string }
    puts "\n\n"
  end
  #adds a new todo.
  def self.add_task(todohash)
    Todo.create!(todo_text: todohash[:todo_text], due_date: Date.today + todohash[:due_in_days], completed: false)
  end
  #Marks a todo as complete.
  def self.mark_as_complete(todo_id)
    Todo.find(todo_id).update(completed: true)
    exit
  end
end
