echo Iniciando instalaçao das libs no repositório maven local
call mvn install:install-file -Dfile=Qrcode.jar -DgroupId=com.swetake.util -DartifactId=Qrcode -Dversion=1.0.0 -Dpackaging=jar
call mvn install:install-file -Dfile=ss_css2.jar -DgroupId=com.steadystate.css.parser -DartifactId=ss_css2 -Dversion=1.0.0 -Dpackaging=jar
call mvn install:install-file -Dfile=jbpm-jpdl.jar -DgroupId=jbpm -DartifactId=jbpm-jpdl -Dversion=1.0.0 -Dpackaging=jar
call mvn install:install-file -Dfile=jbpm-identity.jar -DgroupId=jbpm -DartifactId=jbpm-identity -Dversion=1.0.0 -Dpackaging=jar
call mvn install:install-file -Dfile=WikiParser.jar -DgroupId=ys.wikiparser -DartifactId=WikiParser -Dversion=1.0.0 -Dpackaging=jar
call mvn install:install-file -Dfile=ojdbc6.jar -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.3.0 -Dpackaging=jar
call mvn install:install-file -Dfile=hibernate-validator-legacy-3.1.0.GA.jar -DgroupId=org.hibernate -DartifactId=hibernate-validator-legacy -Dversion=3.1.0.GA -Dpackaging=jar

echo Libs configuradas com sucesso
