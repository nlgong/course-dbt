{% macro grant_select_on_schema(schema, role) %}
  grant usage on schema {{ schema }} to {{ role }};
  grant select on all tables in schema {{ schema }} to {{ role }};
  alter default privileges in schema {{ schema }}
    grant select on tables to {{ role }};
{% endmacro %}