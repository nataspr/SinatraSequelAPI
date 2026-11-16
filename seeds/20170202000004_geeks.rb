Sequel.seed(:development, :test) do
  def run
    DB[:geeks].insert(name: 'Alice', stack: 'Ruby, Sinatra', resume: true)
    DB[:geeks].insert(name: 'Bob', stack: 'JavaScript, React', resume: false)
    DB[:geeks].insert(name: 'Carol', stack: 'Elixir, Phoenix', resume: true)
    DB[:geeks].insert(name: 'Dave', stack: 'Go, PostgreSQL', resume: false)
  end
end