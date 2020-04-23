create or replace package body CHANGEME as

  gc_scope_prefix constant varchar2(31) := lower($$plsql_unit) || '.';


  /**
   * Description
   *
   *
   * @example
   *
   * @issue
   *
   * @author
   * @created
   * @param
   * @return
   */
  procedure CHANGEME_P(
    p_param1_todo in varchar2)
  as
    l_scope logger_logs.scope%type := gc_scope_prefix || 'CHANGEME_P';
    l_params logger.tab_param;

  begin
    logger.append_param(l_params, 'p_param1_todo', p_param1_todo);
    logger.log('START', l_scope, null, l_params);

    ...
    -- All calls to logger should pass in the scope
    ...

    logger.log('END', l_scope);
  exception
    when others then
      logger.log_error('Unhandled Exception', l_scope, null, l_params);
      raise;
  end CHANGEME_P;


end CHANGEME;
/
