using TestRunner
using FactCheck

facts("Facts groups tests") do
  sampleTests = quote
    using FactCheck

    facts("First facts group") do
      @fact 1 --> 1 "First group first test"
      @fact 2 --> 1 "First group second failing test"
    end

    facts("Second facts group") do
      @fact 1 --> 1 "Second group first test"
      @fact 2 --> 2 #Nameless fact
    end

    facts() do #Nameless group
      @fact 1 --> 1 #Nameless fact
      @fact 2 --> 1 #Failing nameless fact in nameless group
    end
    facts() do
    end
  end

  @fact TestRunner.get_facts_groups(sampleTests) --> [
                                                       ("First facts group", ["First group first test", "First group second failing test"]),
                                                       ("Second facts group", ["Second group first test", ""]),
                                                       ("", ["",""]),
                                                       ("",[])
                                                     ]
end
