#!/usr/local/bin/ruby -w

usuarioCorporativo="corporativo"
senhaCorporativo=""

usuarioSiga="siga"
senhaSiga=""

host="localhost"
port="1521"
sid="xe"

for i in 1..10
   puts "Executando  @CORPORATIVO_UTF8_V#{i}_0__Description.sql"   
   system "echo exit | sqlplus #{usuarioCorporativo}/#{senhaCorporativo}@#{host}:#{port}/#{sid} @./corporativo/CORPORATIVO_UTF8_V#{i}_0__Description.sql > ./log/logCORP#{i}.txt" 
end

for i in 1..13
   if i == 1
      for j in 0..2
        puts "Executando  @SIGA_UTF8_V#{i}_#{j}__Description.sql"
        system "echo exit | sqlplus #{usuarioSiga}/#{senhaSiga}@#{host}:#{port}/#{sid} @./siga/SIGA_UTF8_V#{i}_#{j}__Description.sql > ./log/logSIGA#{i}.txt" 
      end
   else
     puts "Executando  @SIGA_UTF8_V#{i}_0__Description.sql"
     system "echo exit | sqlplus #{usuarioSiga}/#{senhaSiga}@#{host}:#{port}/#{sid} @./siga/SIGA_UTF8_V#{i}_0__Description.sql > ./log/logSIGA#{i}.txt" 
   end
end

for i in 11..27
   puts "Executando  @CORPORATIVO_UTF8_V#{i}_0__Description.sql"
   system "echo exit | sqlplus #{usuarioCorporativo}/#{senhaCorporativo}@#{host}:#{port}/#{sid} @./corporativo/CORPORATIVO_UTF8_V#{i}_0__Description.sql > ./log/logCORP#{i}.txt" 
end

for i in 14..25
   puts "Executando  @SIGA_UTF8_V#{i}_0__Description.sql"
   system "echo exit | sqlplus #{usuarioSiga}/#{senhaSiga}@#{host}:#{port}/#{sid} @./siga/SIGA_UTF8_V#{i}_0__Description.sql > ./log/logSIGA#{i}.txt"   
end

