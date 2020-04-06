# Fact dat de waarde toont van read_only flag in mysqld.
# Als de mysql server niet draait geven we niets terug.
Facter.add('mysqld_readonly') do
  setcode do
    begin
      val = Facter::Core::Execution.execute('/usr/bin/mysql -N -e "show global variables like \'read_only\'"', options = {:timeout => 5})
      val.split(/\t/)[1]
    rescue Facter::Core::Execution::ExecutionFailure
      ''
    end
  end
end
