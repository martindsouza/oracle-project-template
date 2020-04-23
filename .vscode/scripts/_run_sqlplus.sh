# make sure script uses correct environment settings for sqlplus
# source ~/.profile

# Env variables $1, $2, etc are from the tasks.json args array

# Colors
RED='\033[0;31m'
LIGHT_GREEN='\033[0;92m'
NC='\033[0m' # No Color

# Get the database connection string
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ENV_FILE_NAME="../vsc-task-env"
ENV_FILE=$DIR/$ENV_FILE_NAME
SQL_FILE_COLOR=$DIR/colors.sql

# Check if connection file is missing
if [ ! -f $ENV_FILE ]; then
  echo "$ENV_FILE is not found, generating\n"
  echo "ORACLE_SQL_CONNECTION=\"CHANGEME\"" > $ENV_FILE
fi

# Load connection script
source $ENV_FILE

if [ -z "$ORACLE_SQL_CONNECTION" ] || [ $ORACLE_SQL_CONNECTION = "CHANGEME" ] ; then
  echo -e "${RED}*** CONFIG ERROR ***\n${NC}You need to edit ${LIGHT_GREEN}$ENV_FILE${NC} and define the full connection string to your database. Ex: ${LIGHT_GREEN}giffy/giffy@localhost:32122/orclpdb514.localdomain${NC}"
  echo -e "Opening File"
  code $ENV_FILE
  # End process
  kill -INT $$
fi

echo -e "Parsing file: ${LIGHT_GREEN}$2${NC}"
echo -e "pwd: $PWD"
# run sqlplus, execute the script, then get the error list and exit
# sqlcl $1 << EOF
# Note: remove the "-it" for TTY issue
# Seems to be an issue with multiline alias and EOF in this situation
alias sqlcl='docker run -i --rm --network="host" -v `pwd`:/sqlcl -v ~/Documents/Oracle/:/oracle -e TNS_ADMIN=$TNS_ADMIN oracle-sqlcl:latest '

sqlcl $ORACLE_SQL_CONNECTION << EOF
set define off
--
alter session set plsql_ccflags = 'dev_env:true';
--
$2
--
set define on
-- @$SQL_FILE_COLOR
-- Colors: http://orasql.org/2013/05/22/sqlplus-tips-6-colorizing-output/
-- prompt &_C_RED
show errors
-- prompt &_C_RESET
-- @_show_errors.sql $3
exit;
EOF



