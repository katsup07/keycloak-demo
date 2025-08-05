--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE keycloak;
ALTER ROLE keycloak WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:vJoUHRpn01740sKCxOW3FA==$OoubkvYe7gbadEBguCEkorIoiGWcFvjRMsbJ9pxtKWU=:8d5zrAYxNaXyXp4PkfU06zWKIetQyLuiMPBeWGt1J28=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- Database "keycloak" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: keycloak; Type: DATABASE; Schema: -; Owner: keycloak
--

CREATE DATABASE keycloak WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE keycloak OWNER TO keycloak;

\connect keycloak

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer,
    version integer DEFAULT 0
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL,
    description character varying(255)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: server_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.server_config (
    server_config_key character varying(255) NOT NULL,
    value text NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.server_config OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
7fc985a7-0e96-464e-a4fd-8d98ec922550	\N	auth-cookie	e4ec3424-6c77-4ffb-856a-e7222a16b801	45b557b3-ca28-4ebc-828e-7e5d275e6d1b	2	10	f	\N	\N
bc620953-8949-440e-88e3-e8588c702ccb	\N	auth-spnego	e4ec3424-6c77-4ffb-856a-e7222a16b801	45b557b3-ca28-4ebc-828e-7e5d275e6d1b	3	20	f	\N	\N
cffe34a2-433d-4d6c-a212-a894109bdd59	\N	identity-provider-redirector	e4ec3424-6c77-4ffb-856a-e7222a16b801	45b557b3-ca28-4ebc-828e-7e5d275e6d1b	2	25	f	\N	\N
11024672-b050-495c-950a-b4da3a6259c5	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	45b557b3-ca28-4ebc-828e-7e5d275e6d1b	2	30	t	d7818bd4-a929-4a59-803d-728abf95547d	\N
4d15d2c4-430a-4b8e-9e2a-cb985b830caa	\N	auth-username-password-form	e4ec3424-6c77-4ffb-856a-e7222a16b801	d7818bd4-a929-4a59-803d-728abf95547d	0	10	f	\N	\N
b7e10c7b-e7b7-4082-854c-c207f34d15c1	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	d7818bd4-a929-4a59-803d-728abf95547d	1	20	t	0873df2e-b705-445d-9306-9843623a648d	\N
583f43de-3dfb-4c46-8b9e-40189e59107c	\N	conditional-user-configured	e4ec3424-6c77-4ffb-856a-e7222a16b801	0873df2e-b705-445d-9306-9843623a648d	0	10	f	\N	\N
72d1e47e-9151-4442-8c01-e9ac2c0c52ac	\N	auth-otp-form	e4ec3424-6c77-4ffb-856a-e7222a16b801	0873df2e-b705-445d-9306-9843623a648d	0	20	f	\N	\N
1ae52c5a-f43f-46b1-89eb-fce24455a663	\N	direct-grant-validate-username	e4ec3424-6c77-4ffb-856a-e7222a16b801	f28c5649-8795-4e64-a915-dc90f62ba0b5	0	10	f	\N	\N
7b4d9ed3-392b-4254-8a6e-01ede0a757fb	\N	direct-grant-validate-password	e4ec3424-6c77-4ffb-856a-e7222a16b801	f28c5649-8795-4e64-a915-dc90f62ba0b5	0	20	f	\N	\N
d337971f-e70f-4d79-b03e-79ec429c72c4	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	f28c5649-8795-4e64-a915-dc90f62ba0b5	1	30	t	5abeeb3a-387f-485b-aff1-b1f4ce73cb46	\N
0d5ba9f4-e900-4917-b635-17b668585513	\N	conditional-user-configured	e4ec3424-6c77-4ffb-856a-e7222a16b801	5abeeb3a-387f-485b-aff1-b1f4ce73cb46	0	10	f	\N	\N
13042664-34db-46c0-9e2c-253246b93f37	\N	direct-grant-validate-otp	e4ec3424-6c77-4ffb-856a-e7222a16b801	5abeeb3a-387f-485b-aff1-b1f4ce73cb46	0	20	f	\N	\N
fd5240fd-6584-4e12-a5e9-52b00511dcbe	\N	registration-page-form	e4ec3424-6c77-4ffb-856a-e7222a16b801	5772e977-c129-43bb-9a18-890151314a47	0	10	t	04a8c644-4c0f-4a23-825d-89e49145cd05	\N
8a33f2ed-aefe-4235-8cc8-3278c565e11f	\N	registration-user-creation	e4ec3424-6c77-4ffb-856a-e7222a16b801	04a8c644-4c0f-4a23-825d-89e49145cd05	0	20	f	\N	\N
6e45ac7d-9ce1-41cc-8f66-6a65d05ba948	\N	registration-password-action	e4ec3424-6c77-4ffb-856a-e7222a16b801	04a8c644-4c0f-4a23-825d-89e49145cd05	0	50	f	\N	\N
b764236e-7b13-4d2f-9898-79f22f810902	\N	registration-recaptcha-action	e4ec3424-6c77-4ffb-856a-e7222a16b801	04a8c644-4c0f-4a23-825d-89e49145cd05	3	60	f	\N	\N
f41606d9-23e2-47fc-871f-d823d9223408	\N	registration-terms-and-conditions	e4ec3424-6c77-4ffb-856a-e7222a16b801	04a8c644-4c0f-4a23-825d-89e49145cd05	3	70	f	\N	\N
914cce2b-88f4-4b84-803f-077d97a57826	\N	reset-credentials-choose-user	e4ec3424-6c77-4ffb-856a-e7222a16b801	b0715148-8a8c-4842-a5ee-7f11a311a558	0	10	f	\N	\N
b66cb2bf-4b04-4086-ae25-8b89ffb0c4a9	\N	reset-credential-email	e4ec3424-6c77-4ffb-856a-e7222a16b801	b0715148-8a8c-4842-a5ee-7f11a311a558	0	20	f	\N	\N
66143fd3-971d-43de-bf0f-2f3a0efee7a6	\N	reset-password	e4ec3424-6c77-4ffb-856a-e7222a16b801	b0715148-8a8c-4842-a5ee-7f11a311a558	0	30	f	\N	\N
0ee0812b-f077-4dd6-9658-d52193c749c3	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	b0715148-8a8c-4842-a5ee-7f11a311a558	1	40	t	d3a4f817-239e-49a5-b7ec-b84464db75e5	\N
0442fdc9-e694-4179-8599-01d42f2c3717	\N	conditional-user-configured	e4ec3424-6c77-4ffb-856a-e7222a16b801	d3a4f817-239e-49a5-b7ec-b84464db75e5	0	10	f	\N	\N
5c136569-06e9-481e-b6da-0cad7ee0fd80	\N	reset-otp	e4ec3424-6c77-4ffb-856a-e7222a16b801	d3a4f817-239e-49a5-b7ec-b84464db75e5	0	20	f	\N	\N
7a0bbb5c-3377-4c22-b16e-88987c695c7c	\N	client-secret	e4ec3424-6c77-4ffb-856a-e7222a16b801	d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	2	10	f	\N	\N
cbea5adf-479c-4cb2-be5e-7a6b47f1ca08	\N	client-jwt	e4ec3424-6c77-4ffb-856a-e7222a16b801	d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	2	20	f	\N	\N
af32ec2c-337e-4bb8-bbd8-249a1e8be073	\N	client-secret-jwt	e4ec3424-6c77-4ffb-856a-e7222a16b801	d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	2	30	f	\N	\N
a049f43b-a08c-45a3-927c-cd673156359f	\N	client-x509	e4ec3424-6c77-4ffb-856a-e7222a16b801	d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	2	40	f	\N	\N
0d43da46-d557-4194-ba03-723c97498c6d	\N	idp-review-profile	e4ec3424-6c77-4ffb-856a-e7222a16b801	18f85422-d256-4cbb-a811-7559a03b2e1b	0	10	f	\N	7e97f952-756e-4728-8faa-37b1b81ad84d
78d41118-9e4a-4438-a940-2c7f3874cdbc	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	18f85422-d256-4cbb-a811-7559a03b2e1b	0	20	t	b57cd97b-1d4c-4072-be6d-43566118551b	\N
2b26389a-12a6-4c8c-8751-47d47dcbce09	\N	idp-create-user-if-unique	e4ec3424-6c77-4ffb-856a-e7222a16b801	b57cd97b-1d4c-4072-be6d-43566118551b	2	10	f	\N	0ca6f9a4-4ba6-4ef3-9118-4e60eb3204b2
c088561a-5f6f-41bf-ab32-62dce26aade0	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	b57cd97b-1d4c-4072-be6d-43566118551b	2	20	t	6b18d550-be69-40f0-b36a-ce00146abdf2	\N
88fe889d-aa7b-4d53-bb50-a8d4ee9c1e0a	\N	idp-confirm-link	e4ec3424-6c77-4ffb-856a-e7222a16b801	6b18d550-be69-40f0-b36a-ce00146abdf2	0	10	f	\N	\N
03dc2c16-dbc7-4b64-b51c-1c8383172342	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	6b18d550-be69-40f0-b36a-ce00146abdf2	0	20	t	e99a0e06-d70b-42cd-85f3-3e61b6b42b9f	\N
1fa709fa-6822-4c8e-86d0-3ccb736ad830	\N	idp-email-verification	e4ec3424-6c77-4ffb-856a-e7222a16b801	e99a0e06-d70b-42cd-85f3-3e61b6b42b9f	2	10	f	\N	\N
9fc7554e-2b5c-477b-9ba5-02f71b190f3c	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	e99a0e06-d70b-42cd-85f3-3e61b6b42b9f	2	20	t	6528d762-e117-4c25-9662-62f2b0c81542	\N
9d640659-25bd-4ec5-8666-7fba5ea5497f	\N	idp-username-password-form	e4ec3424-6c77-4ffb-856a-e7222a16b801	6528d762-e117-4c25-9662-62f2b0c81542	0	10	f	\N	\N
8ff49f26-db13-44b7-a7eb-0f6f48f9343a	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	6528d762-e117-4c25-9662-62f2b0c81542	1	20	t	b118bde9-df6f-4a59-b651-a632f79d4d3d	\N
a621fe22-f46b-4768-b653-bf950f5156dd	\N	conditional-user-configured	e4ec3424-6c77-4ffb-856a-e7222a16b801	b118bde9-df6f-4a59-b651-a632f79d4d3d	0	10	f	\N	\N
ee02aa29-ed9e-4e0b-ab0a-3b244cf970fe	\N	auth-otp-form	e4ec3424-6c77-4ffb-856a-e7222a16b801	b118bde9-df6f-4a59-b651-a632f79d4d3d	0	20	f	\N	\N
532b87d1-3f61-470e-af1c-723ecda9fc82	\N	http-basic-authenticator	e4ec3424-6c77-4ffb-856a-e7222a16b801	68d4a758-bbb3-4ca8-a8a1-61b93f34c7f3	0	10	f	\N	\N
d889486b-2c6d-49d5-8145-fc67440264c3	\N	docker-http-basic-authenticator	e4ec3424-6c77-4ffb-856a-e7222a16b801	e5f5bac3-7c93-4b3d-8fa2-0da5d52e61e6	0	10	f	\N	\N
2674b1b6-c118-45b4-9191-673e31abd880	\N	auth-cookie	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	6b5f775a-a9bf-4aa7-9dde-111e172ece6b	2	10	f	\N	\N
d7c023ce-03fe-4d49-a032-1285269c9218	\N	auth-spnego	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	6b5f775a-a9bf-4aa7-9dde-111e172ece6b	3	20	f	\N	\N
c83c9bc0-8bea-4bf6-aa23-ee218628d3d6	\N	identity-provider-redirector	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	6b5f775a-a9bf-4aa7-9dde-111e172ece6b	2	25	f	\N	\N
d614052d-550e-4276-9ecf-b658bac55b98	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	6b5f775a-a9bf-4aa7-9dde-111e172ece6b	2	30	t	99daa5cf-2d2c-41ca-bd78-458632b6339c	\N
ee089177-9700-432e-b987-d17b3afa459c	\N	auth-username-password-form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	99daa5cf-2d2c-41ca-bd78-458632b6339c	0	10	f	\N	\N
4adace58-ccc6-4f0a-98cc-d942a220774c	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	99daa5cf-2d2c-41ca-bd78-458632b6339c	1	20	t	b0222519-13d8-424b-847a-4b28c623493f	\N
fda520da-37e9-4eab-a3a7-7186120ee16f	\N	conditional-user-configured	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b0222519-13d8-424b-847a-4b28c623493f	0	10	f	\N	\N
b01cdd65-bd29-4fe8-a144-1c712d03e3aa	\N	auth-otp-form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b0222519-13d8-424b-847a-4b28c623493f	0	20	f	\N	\N
84c42c45-73ce-4f0d-bcac-748201222799	\N	direct-grant-validate-username	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	82862847-425e-4248-a02c-25ce67832f75	0	10	f	\N	\N
e74340ef-a5bb-434b-8095-d648a974575c	\N	direct-grant-validate-password	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	82862847-425e-4248-a02c-25ce67832f75	0	20	f	\N	\N
e44a1fc9-bd3a-4864-b12d-39c17ea4862e	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	82862847-425e-4248-a02c-25ce67832f75	1	30	t	d2d9bf96-0688-4c5d-b929-5fbaaeea290d	\N
7bb9580c-04f0-4430-9ed9-5a415016311e	\N	conditional-user-configured	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	d2d9bf96-0688-4c5d-b929-5fbaaeea290d	0	10	f	\N	\N
6cdaaeb9-9458-4a19-a648-f2f222d87036	\N	direct-grant-validate-otp	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	d2d9bf96-0688-4c5d-b929-5fbaaeea290d	0	20	f	\N	\N
9df74766-edd5-42ab-9fe2-1d105b0d77f2	\N	registration-page-form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	1c65da9a-5ad1-46fb-a70e-5a9ba8033176	0	10	t	74d462cf-bfad-47d9-aebb-54e613fe49ef	\N
5379eff9-fa3b-488a-9f80-3a73cd12a6a5	\N	registration-user-creation	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	74d462cf-bfad-47d9-aebb-54e613fe49ef	0	20	f	\N	\N
91f938d9-80f5-44f7-b160-3590bc4c89db	\N	registration-password-action	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	74d462cf-bfad-47d9-aebb-54e613fe49ef	0	50	f	\N	\N
1462b194-f237-4de8-b9be-d13463d89157	\N	registration-recaptcha-action	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	74d462cf-bfad-47d9-aebb-54e613fe49ef	3	60	f	\N	\N
b831bb8e-72d5-4ff4-a320-d89b7c8baa8a	\N	reset-credentials-choose-user	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	cd7477c7-7e90-4fe1-9fa4-f724a58be309	0	10	f	\N	\N
ab1f3ca6-d218-458d-8b94-5fc9f9d0cc70	\N	reset-credential-email	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	cd7477c7-7e90-4fe1-9fa4-f724a58be309	0	20	f	\N	\N
e0e49003-b965-48b7-9a20-1cd8078590b8	\N	reset-password	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	cd7477c7-7e90-4fe1-9fa4-f724a58be309	0	30	f	\N	\N
a8cb8662-e197-4ded-8c6d-b55eaac6a9e1	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	cd7477c7-7e90-4fe1-9fa4-f724a58be309	1	40	t	2f9137f9-abdb-4f2e-89c1-14d4ae51e488	\N
0a647882-92af-4caa-9cb1-03ff99c6e400	\N	conditional-user-configured	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	2f9137f9-abdb-4f2e-89c1-14d4ae51e488	0	10	f	\N	\N
b8ae7b9a-b85a-40c8-88c0-dbac43931690	\N	reset-otp	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	2f9137f9-abdb-4f2e-89c1-14d4ae51e488	0	20	f	\N	\N
dfc478e1-1e79-431c-ac01-4533526b2fe1	\N	client-secret	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b544dc7a-b766-4f57-855c-6da19573b6af	2	10	f	\N	\N
7094b4df-2961-4e7f-b2c7-bea08e998bd1	\N	client-jwt	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b544dc7a-b766-4f57-855c-6da19573b6af	2	20	f	\N	\N
794db986-a602-4faa-9527-dc495c3920f6	\N	client-secret-jwt	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b544dc7a-b766-4f57-855c-6da19573b6af	2	30	f	\N	\N
b004d449-0f9e-4cbf-90f7-684beb6fa45b	\N	client-x509	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	b544dc7a-b766-4f57-855c-6da19573b6af	2	40	f	\N	\N
3f6ae566-833d-4a5c-a7ec-f0fc390196a3	\N	idp-review-profile	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c87ac2cf-cffe-45e2-93a2-971746fe3c8d	0	10	f	\N	c4a7b317-df22-4962-ae04-776f68b9a868
e1d43247-199b-430e-8912-f54e1ec3dda6	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c87ac2cf-cffe-45e2-93a2-971746fe3c8d	0	20	t	fa3b6340-e846-4bb3-a58e-62745899d4ab	\N
98564bf0-8ee6-464d-b04b-b4cdafa5acea	\N	idp-create-user-if-unique	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	fa3b6340-e846-4bb3-a58e-62745899d4ab	2	10	f	\N	a423b1cd-057f-4186-a2e0-057b2b28c266
84c3119c-8048-477a-86d8-1adcb1ae2e16	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	fa3b6340-e846-4bb3-a58e-62745899d4ab	2	20	t	17223a3d-65dd-4620-a992-63d3e1b8c880	\N
8430eccc-fd27-477b-9459-55f2c8239baf	\N	idp-confirm-link	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	17223a3d-65dd-4620-a992-63d3e1b8c880	0	10	f	\N	\N
a1ca04e0-d8f0-49c5-8466-5664cb841d9e	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	17223a3d-65dd-4620-a992-63d3e1b8c880	0	20	t	004547aa-293f-440a-aa56-71e9ba7a3c84	\N
a225c404-0dad-400e-883c-92be8618f2ca	\N	idp-email-verification	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	004547aa-293f-440a-aa56-71e9ba7a3c84	2	10	f	\N	\N
3463c888-cae7-4ad5-a987-ed1236e4a78f	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	004547aa-293f-440a-aa56-71e9ba7a3c84	2	20	t	d716c2e8-1e93-4ae2-a9d1-8d1fc04c0d0f	\N
afb3ba42-0984-4fd1-b13a-8aae75cdc10c	\N	idp-username-password-form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	d716c2e8-1e93-4ae2-a9d1-8d1fc04c0d0f	0	10	f	\N	\N
79707995-cb1d-4405-abd7-1a8c9985e9b9	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	d716c2e8-1e93-4ae2-a9d1-8d1fc04c0d0f	1	20	t	ce15c85e-b4b1-4ecd-9196-237aede0a15c	\N
bf9ba581-a565-4153-a9db-51e2931bd336	\N	conditional-user-configured	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	ce15c85e-b4b1-4ecd-9196-237aede0a15c	0	10	f	\N	\N
9e679f96-dd41-41fb-b072-8d51a368cc8b	\N	auth-otp-form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	ce15c85e-b4b1-4ecd-9196-237aede0a15c	0	20	f	\N	\N
5f8b2072-0439-4827-bc5f-fddec2170a59	\N	http-basic-authenticator	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f3fa095b-cb91-4a8a-9c30-4bee758de9aa	0	10	f	\N	\N
9600393a-fddb-4ba9-b653-ec475482d837	\N	docker-http-basic-authenticator	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	5f0ab695-459c-4808-b2f5-b4b51b4f5c9b	0	10	f	\N	\N
76d9fcbe-c9b7-4b5b-ab1b-d2c22602127e	\N	auth-cookie	e5342017-007b-4615-8c72-27d89b5f59ae	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	2	10	f	\N	\N
ed6299cc-61f3-4647-8c6f-6318c6342c9d	\N	auth-spnego	e5342017-007b-4615-8c72-27d89b5f59ae	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	3	20	f	\N	\N
c78a1737-46ad-47de-921f-49855e332f7c	\N	identity-provider-redirector	e5342017-007b-4615-8c72-27d89b5f59ae	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	2	25	f	\N	\N
f858a760-6ad6-464c-be94-3c44582cbcad	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	2	30	t	9f8920d1-a686-4554-a7ee-5f4d65dd18ae	\N
1df1c586-c99f-48c3-8dac-1b1ccd879ad5	\N	auth-username-password-form	e5342017-007b-4615-8c72-27d89b5f59ae	9f8920d1-a686-4554-a7ee-5f4d65dd18ae	0	10	f	\N	\N
3b8b4055-20a5-4b21-abb1-6d6dbe5bc71b	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	9f8920d1-a686-4554-a7ee-5f4d65dd18ae	1	20	t	e972a0a7-eda6-476f-8d5d-b53b0af5d303	\N
7a4cd7c9-7364-47b8-83d6-ea30e7def109	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	e972a0a7-eda6-476f-8d5d-b53b0af5d303	0	10	f	\N	\N
6cd0651c-e002-4266-8560-14e46960fe42	\N	auth-otp-form	e5342017-007b-4615-8c72-27d89b5f59ae	e972a0a7-eda6-476f-8d5d-b53b0af5d303	2	20	f	\N	\N
f77c87e6-3bb9-4821-816f-39e63f2d1897	\N	webauthn-authenticator	e5342017-007b-4615-8c72-27d89b5f59ae	e972a0a7-eda6-476f-8d5d-b53b0af5d303	3	30	f	\N	\N
9bf2d9ff-a44a-4c98-8ba0-ba834c8ec0cd	\N	auth-recovery-authn-code-form	e5342017-007b-4615-8c72-27d89b5f59ae	e972a0a7-eda6-476f-8d5d-b53b0af5d303	3	40	f	\N	\N
e5c96408-fbd3-4e41-8435-9fc4402eab38	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	2	26	t	b48f79f4-a54d-4970-9c22-9b14e4d5b519	\N
5573370f-bdc3-4bf3-bc1e-2f4bc2b18e69	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	b48f79f4-a54d-4970-9c22-9b14e4d5b519	1	10	t	4dbe378d-da88-428b-a499-e07f19c5c035	\N
caa9d445-12ea-4874-8ed4-1736748c3134	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	4dbe378d-da88-428b-a499-e07f19c5c035	0	10	f	\N	\N
fbc03388-727d-47ff-87cc-6708ca36b83d	\N	organization	e5342017-007b-4615-8c72-27d89b5f59ae	4dbe378d-da88-428b-a499-e07f19c5c035	2	20	f	\N	\N
3f0a7c4a-1c8f-4df4-8b68-ffb31dc0bff3	\N	direct-grant-validate-username	e5342017-007b-4615-8c72-27d89b5f59ae	db41e3f6-21ac-4fd7-b067-ae6510ec575c	0	10	f	\N	\N
912cda65-b119-4be3-86a2-a88816bc7912	\N	direct-grant-validate-password	e5342017-007b-4615-8c72-27d89b5f59ae	db41e3f6-21ac-4fd7-b067-ae6510ec575c	0	20	f	\N	\N
eef73ba4-4eae-4e07-8be7-94e88be7e3f7	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	db41e3f6-21ac-4fd7-b067-ae6510ec575c	1	30	t	a352b8b1-d40f-4065-908e-2a933209069f	\N
64dda606-b7ab-4a05-a5fa-7cbda503aaa4	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	a352b8b1-d40f-4065-908e-2a933209069f	0	10	f	\N	\N
1bd39f37-5bf8-4678-93b3-6d8233ce329e	\N	direct-grant-validate-otp	e5342017-007b-4615-8c72-27d89b5f59ae	a352b8b1-d40f-4065-908e-2a933209069f	0	20	f	\N	\N
e9c9b1ca-03c2-4f34-8176-16b3e4f8473c	\N	registration-page-form	e5342017-007b-4615-8c72-27d89b5f59ae	d7e9983a-d3ba-4304-8bdc-2fa59bb19500	0	10	t	661e6e35-1ae1-4dbf-87a0-db07e9529828	\N
e0f024b7-abfe-4074-a16c-49c2df8dbd50	\N	registration-user-creation	e5342017-007b-4615-8c72-27d89b5f59ae	661e6e35-1ae1-4dbf-87a0-db07e9529828	0	20	f	\N	\N
bcd2b8b4-973f-4a14-bebd-d1bbc808702b	\N	registration-password-action	e5342017-007b-4615-8c72-27d89b5f59ae	661e6e35-1ae1-4dbf-87a0-db07e9529828	0	50	f	\N	\N
7001a8cd-0f06-489a-9451-3b3f76ac419b	\N	registration-recaptcha-action	e5342017-007b-4615-8c72-27d89b5f59ae	661e6e35-1ae1-4dbf-87a0-db07e9529828	3	60	f	\N	\N
4afbabad-d868-4ada-bcc0-86e14845ee88	\N	registration-terms-and-conditions	e5342017-007b-4615-8c72-27d89b5f59ae	661e6e35-1ae1-4dbf-87a0-db07e9529828	3	70	f	\N	\N
a04b24ec-ed16-483f-b692-621eae580100	\N	reset-credentials-choose-user	e5342017-007b-4615-8c72-27d89b5f59ae	14639de8-37e0-4ae5-9097-2177bf376848	0	10	f	\N	\N
8f4a20c6-e5e1-4030-b1ec-4d6b4b59b4fa	\N	reset-credential-email	e5342017-007b-4615-8c72-27d89b5f59ae	14639de8-37e0-4ae5-9097-2177bf376848	0	20	f	\N	\N
c6067ea9-7eb9-4415-8d58-0223591f699a	\N	reset-password	e5342017-007b-4615-8c72-27d89b5f59ae	14639de8-37e0-4ae5-9097-2177bf376848	0	30	f	\N	\N
1b6f11dc-9e9e-40de-87c0-e56ba36d601b	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	14639de8-37e0-4ae5-9097-2177bf376848	1	40	t	d859c711-6ed4-49f8-a8cb-f03ecfcc8cc4	\N
5a802151-3da6-43d7-9f09-82e3df22074e	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	d859c711-6ed4-49f8-a8cb-f03ecfcc8cc4	0	10	f	\N	\N
dd1a9509-828f-47ac-bfbd-543cb0f31c26	\N	reset-otp	e5342017-007b-4615-8c72-27d89b5f59ae	d859c711-6ed4-49f8-a8cb-f03ecfcc8cc4	0	20	f	\N	\N
29ec82dc-293c-4525-8d8e-fac11570e420	\N	client-secret	e5342017-007b-4615-8c72-27d89b5f59ae	0040d466-af9b-490f-8fba-449c508cb254	2	10	f	\N	\N
2940af21-5efb-47b5-918e-c9a3ee4d7868	\N	client-jwt	e5342017-007b-4615-8c72-27d89b5f59ae	0040d466-af9b-490f-8fba-449c508cb254	2	20	f	\N	\N
cee49bae-e6df-4e40-8b6b-40774cbac6f4	\N	client-secret-jwt	e5342017-007b-4615-8c72-27d89b5f59ae	0040d466-af9b-490f-8fba-449c508cb254	2	30	f	\N	\N
3fa8b332-94e3-4224-9038-3fcf6a369824	\N	client-x509	e5342017-007b-4615-8c72-27d89b5f59ae	0040d466-af9b-490f-8fba-449c508cb254	2	40	f	\N	\N
0b6212ce-bd39-413f-a088-691e6665b6c0	\N	idp-review-profile	e5342017-007b-4615-8c72-27d89b5f59ae	df1b8d09-988e-48d8-bd7a-710c59ffaf2e	0	10	f	\N	a97a3123-9938-4023-9558-bebb2540b36b
0bd22f59-75a0-4f33-985c-3dbdff8859b9	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	df1b8d09-988e-48d8-bd7a-710c59ffaf2e	0	20	t	8f518982-ab6d-40fc-a7ba-d1a4fd3c007b	\N
d7884806-f421-47a1-b809-e1f8c5967a8a	\N	idp-create-user-if-unique	e5342017-007b-4615-8c72-27d89b5f59ae	8f518982-ab6d-40fc-a7ba-d1a4fd3c007b	2	10	f	\N	b3f6fb72-af9c-4757-9993-bd074f708aa6
522d242b-e458-47b5-9a4c-f564730c8e32	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	8f518982-ab6d-40fc-a7ba-d1a4fd3c007b	2	20	t	8a9398ec-417e-4a50-8b2e-a944342794c8	\N
8e1c777f-fd7a-4cc1-b6c8-0a8a5f0538c5	\N	idp-confirm-link	e5342017-007b-4615-8c72-27d89b5f59ae	8a9398ec-417e-4a50-8b2e-a944342794c8	0	10	f	\N	\N
b2ef51b8-cf53-42e1-aba0-0e05444558d0	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	8a9398ec-417e-4a50-8b2e-a944342794c8	0	20	t	66f21a45-688d-491a-9f85-122e10668029	\N
a516c6fa-e8d3-45ba-a68f-083d053942d9	\N	idp-email-verification	e5342017-007b-4615-8c72-27d89b5f59ae	66f21a45-688d-491a-9f85-122e10668029	2	10	f	\N	\N
adf465fc-e250-4417-b98c-ac40bf499685	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	66f21a45-688d-491a-9f85-122e10668029	2	20	t	d32a4644-78c4-4f96-855a-55e2bd5f49f9	\N
8116207d-97e5-4f5a-b693-d1fe76005ca7	\N	idp-username-password-form	e5342017-007b-4615-8c72-27d89b5f59ae	d32a4644-78c4-4f96-855a-55e2bd5f49f9	0	10	f	\N	\N
28d50cbd-7ea9-490a-9aec-8a378f43d916	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	d32a4644-78c4-4f96-855a-55e2bd5f49f9	1	20	t	41a22115-8487-45c0-8851-b1ba3314b2bd	\N
bbda933c-2d7a-482e-8798-db1edd2e41a9	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	41a22115-8487-45c0-8851-b1ba3314b2bd	0	10	f	\N	\N
9c640920-8a9e-485e-8d80-43132bd25763	\N	auth-otp-form	e5342017-007b-4615-8c72-27d89b5f59ae	41a22115-8487-45c0-8851-b1ba3314b2bd	2	20	f	\N	\N
0eff71cd-71df-4077-9a7a-1825f104d11d	\N	webauthn-authenticator	e5342017-007b-4615-8c72-27d89b5f59ae	41a22115-8487-45c0-8851-b1ba3314b2bd	3	30	f	\N	\N
f2caebe6-59c9-4133-b81d-2f19a89f1f13	\N	auth-recovery-authn-code-form	e5342017-007b-4615-8c72-27d89b5f59ae	41a22115-8487-45c0-8851-b1ba3314b2bd	3	40	f	\N	\N
a88fb867-f0e3-4cfe-9715-1606edae76dc	\N	\N	e5342017-007b-4615-8c72-27d89b5f59ae	df1b8d09-988e-48d8-bd7a-710c59ffaf2e	1	50	t	1f60f5f2-6ae5-4667-9644-27941c1c04ce	\N
08c22981-6198-439d-b3ab-7d011df870bd	\N	conditional-user-configured	e5342017-007b-4615-8c72-27d89b5f59ae	1f60f5f2-6ae5-4667-9644-27941c1c04ce	0	10	f	\N	\N
324b1576-87c6-4504-b727-a3352d2b3367	\N	idp-add-organization-member	e5342017-007b-4615-8c72-27d89b5f59ae	1f60f5f2-6ae5-4667-9644-27941c1c04ce	0	20	f	\N	\N
38dff20a-cb24-4617-9660-f638ed61af75	\N	http-basic-authenticator	e5342017-007b-4615-8c72-27d89b5f59ae	0adbecec-0bcb-4ea0-8f41-5bb39d18ef6a	0	10	f	\N	\N
52d64dbd-5415-43a4-a8bb-1526826505be	\N	docker-http-basic-authenticator	e5342017-007b-4615-8c72-27d89b5f59ae	9577a417-6b0d-4f53-92c0-f8b68d015044	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
45b557b3-ca28-4ebc-828e-7e5d275e6d1b	browser	browser based authentication	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
d7818bd4-a929-4a59-803d-728abf95547d	forms	Username, password, otp and other auth forms.	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
0873df2e-b705-445d-9306-9843623a648d	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
f28c5649-8795-4e64-a915-dc90f62ba0b5	direct grant	OpenID Connect Resource Owner Grant	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
5abeeb3a-387f-485b-aff1-b1f4ce73cb46	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
5772e977-c129-43bb-9a18-890151314a47	registration	registration flow	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
04a8c644-4c0f-4a23-825d-89e49145cd05	registration form	registration form	e4ec3424-6c77-4ffb-856a-e7222a16b801	form-flow	f	t
b0715148-8a8c-4842-a5ee-7f11a311a558	reset credentials	Reset credentials for a user if they forgot their password or something	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
d3a4f817-239e-49a5-b7ec-b84464db75e5	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	clients	Base authentication for clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	client-flow	t	t
18f85422-d256-4cbb-a811-7559a03b2e1b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
b57cd97b-1d4c-4072-be6d-43566118551b	User creation or linking	Flow for the existing/non-existing user alternatives	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
6b18d550-be69-40f0-b36a-ce00146abdf2	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
e99a0e06-d70b-42cd-85f3-3e61b6b42b9f	Account verification options	Method with which to verity the existing account	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
6528d762-e117-4c25-9662-62f2b0c81542	Verify Existing Account by Re-authentication	Reauthentication of existing account	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
b118bde9-df6f-4a59-b651-a632f79d4d3d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	f	t
68d4a758-bbb3-4ca8-a8a1-61b93f34c7f3	saml ecp	SAML ECP Profile Authentication Flow	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
e5f5bac3-7c93-4b3d-8fa2-0da5d52e61e6	docker auth	Used by Docker clients to authenticate against the IDP	e4ec3424-6c77-4ffb-856a-e7222a16b801	basic-flow	t	t
6b5f775a-a9bf-4aa7-9dde-111e172ece6b	browser	browser based authentication	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
99daa5cf-2d2c-41ca-bd78-458632b6339c	forms	Username, password, otp and other auth forms.	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
b0222519-13d8-424b-847a-4b28c623493f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
82862847-425e-4248-a02c-25ce67832f75	direct grant	OpenID Connect Resource Owner Grant	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
d2d9bf96-0688-4c5d-b929-5fbaaeea290d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
1c65da9a-5ad1-46fb-a70e-5a9ba8033176	registration	registration flow	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
74d462cf-bfad-47d9-aebb-54e613fe49ef	registration form	registration form	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	form-flow	f	t
cd7477c7-7e90-4fe1-9fa4-f724a58be309	reset credentials	Reset credentials for a user if they forgot their password or something	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
2f9137f9-abdb-4f2e-89c1-14d4ae51e488	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
b544dc7a-b766-4f57-855c-6da19573b6af	clients	Base authentication for clients	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	client-flow	t	t
c87ac2cf-cffe-45e2-93a2-971746fe3c8d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
fa3b6340-e846-4bb3-a58e-62745899d4ab	User creation or linking	Flow for the existing/non-existing user alternatives	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
17223a3d-65dd-4620-a992-63d3e1b8c880	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
004547aa-293f-440a-aa56-71e9ba7a3c84	Account verification options	Method with which to verity the existing account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
d716c2e8-1e93-4ae2-a9d1-8d1fc04c0d0f	Verify Existing Account by Re-authentication	Reauthentication of existing account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
ce15c85e-b4b1-4ecd-9196-237aede0a15c	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	f	t
f3fa095b-cb91-4a8a-9c30-4bee758de9aa	saml ecp	SAML ECP Profile Authentication Flow	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
5f0ab695-459c-4808-b2f5-b4b51b4f5c9b	docker auth	Used by Docker clients to authenticate against the IDP	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	basic-flow	t	t
828a4a4f-dceb-41e9-9096-cbec51cc7d2d	browser	Browser based authentication	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
9f8920d1-a686-4554-a7ee-5f4d65dd18ae	forms	Username, password, otp and other auth forms.	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
e972a0a7-eda6-476f-8d5d-b53b0af5d303	Browser - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
b48f79f4-a54d-4970-9c22-9b14e4d5b519	Organization	\N	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
4dbe378d-da88-428b-a499-e07f19c5c035	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
db41e3f6-21ac-4fd7-b067-ae6510ec575c	direct grant	OpenID Connect Resource Owner Grant	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
a352b8b1-d40f-4065-908e-2a933209069f	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
d7e9983a-d3ba-4304-8bdc-2fa59bb19500	registration	Registration flow	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
661e6e35-1ae1-4dbf-87a0-db07e9529828	registration form	Registration form	e5342017-007b-4615-8c72-27d89b5f59ae	form-flow	f	t
14639de8-37e0-4ae5-9097-2177bf376848	reset credentials	Reset credentials for a user if they forgot their password or something	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
d859c711-6ed4-49f8-a8cb-f03ecfcc8cc4	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
0040d466-af9b-490f-8fba-449c508cb254	clients	Base authentication for clients	e5342017-007b-4615-8c72-27d89b5f59ae	client-flow	t	t
df1b8d09-988e-48d8-bd7a-710c59ffaf2e	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
8f518982-ab6d-40fc-a7ba-d1a4fd3c007b	User creation or linking	Flow for the existing/non-existing user alternatives	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
8a9398ec-417e-4a50-8b2e-a944342794c8	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
66f21a45-688d-491a-9f85-122e10668029	Account verification options	Method with which to verity the existing account	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
d32a4644-78c4-4f96-855a-55e2bd5f49f9	Verify Existing Account by Re-authentication	Reauthentication of existing account	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
41a22115-8487-45c0-8851-b1ba3314b2bd	First broker login - Conditional 2FA	Flow to determine if any 2FA is required for the authentication	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
1f60f5f2-6ae5-4667-9644-27941c1c04ce	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	f	t
0adbecec-0bcb-4ea0-8f41-5bb39d18ef6a	saml ecp	SAML ECP Profile Authentication Flow	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
9577a417-6b0d-4f53-92c0-f8b68d015044	docker auth	Used by Docker clients to authenticate against the IDP	e5342017-007b-4615-8c72-27d89b5f59ae	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
7e97f952-756e-4728-8faa-37b1b81ad84d	review profile config	e4ec3424-6c77-4ffb-856a-e7222a16b801
0ca6f9a4-4ba6-4ef3-9118-4e60eb3204b2	create unique user config	e4ec3424-6c77-4ffb-856a-e7222a16b801
c4a7b317-df22-4962-ae04-776f68b9a868	review profile config	4fd9dee5-48e8-47ac-8e29-554bec7ffeba
a423b1cd-057f-4186-a2e0-057b2b28c266	create unique user config	4fd9dee5-48e8-47ac-8e29-554bec7ffeba
a97a3123-9938-4023-9558-bebb2540b36b	review profile config	e5342017-007b-4615-8c72-27d89b5f59ae
b3f6fb72-af9c-4757-9993-bd074f708aa6	create unique user config	e5342017-007b-4615-8c72-27d89b5f59ae
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0ca6f9a4-4ba6-4ef3-9118-4e60eb3204b2	false	require.password.update.after.registration
7e97f952-756e-4728-8faa-37b1b81ad84d	missing	update.profile.on.first.login
a423b1cd-057f-4186-a2e0-057b2b28c266	false	require.password.update.after.registration
c4a7b317-df22-4962-ae04-776f68b9a868	missing	update.profile.on.first.login
a97a3123-9938-4023-9558-bebb2540b36b	missing	update.profile.on.first.login
b3f6fb72-af9c-4757-9993-bd074f708aa6	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
4310914d-fded-4dd2-b40a-09541da537f8	t	f	master-realm	0	f	\N	\N	t	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
ea386a21-7aad-4aa2-9971-309bc189d04f	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ddad3566-58de-406b-81b8-9e3d0c170c11	t	f	broker	0	f	\N	\N	t	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
300de145-01ed-4ee7-b20a-54327aa0d6e2	t	f	keycloak-demo-realm	0	f	\N	\N	t	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	0	f	f	keycloak-demo Realm	f	client-secret	\N	\N	\N	t	f	f	f
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	f	realm-management	0	f	\N	\N	t	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	f	account	0	t	\N	/realms/keycloak-demo/account/	f	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	t	f	account-console	0	t	\N	/realms/keycloak-demo/account/	f	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
3c61d0de-62ab-4385-b3da-03cf13a8bcde	t	f	broker	0	f	\N	\N	t	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d2d514c2-d51d-4665-a3f7-42b3517261cd	t	t	spring-boot-client	0	f	UX1mzUQA9fBsBVcDyBtM0TvUkbHL2SsY		f		f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	-1	t	f	resource server	f	client-secret		API	\N	t	f	t	f
679e12fb-2ecc-49fb-a12e-27acba8c3001	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
af677b3d-b47d-42bd-b25d-ef928d9175d1	t	t	admin-cli	0	t	\N	\N	f	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
a90de389-2773-4abe-97a0-76c4097f51e1	t	t	security-admin-console	0	t	\N	/admin/keycloak-demo/console/	f	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
5463855b-8b8d-4ecd-8385-3503cafa2acf	t	t	admin-cli	0	t	\N	\N	f	\N	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	f	test-realm	0	f	\N	\N	t	\N	f	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	0	f	f	test Realm	f	client-secret	\N	\N	\N	t	f	f	f
40092299-0564-45c4-a3f8-ea07b2891c33	t	f	realm-management	0	f	\N	\N	t	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
412c16a0-f717-40d0-a0bf-1394aa071e3f	t	f	account	0	t	\N	/realms/test/account/	f	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4655a990-3381-45fa-9109-61cf86c04435	t	f	account-console	0	t	\N	/realms/test/account/	f	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	t	f	broker	0	f	\N	\N	t	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	t	t	security-admin-console	0	t	\N	/admin/test/console/	f	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	t	t	admin-cli	0	t	\N	\N	f	\N	f	e5342017-007b-4615-8c72-27d89b5f59ae	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
eb655986-9bbe-4fee-989f-f414bce735ff	t	t	typescript-express-client	0	f	Yj6jE8i6rTeQ8jS7CX5mXMHiKZILJYyZ		f	http://localhost:8082	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	-1	t	f		f	client-secret	http://localhost:8082		\N	t	f	t	f
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	t	t	react-client	0	t	\N		f		f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	openid-connect	-1	t	f	react-client	f	client-secret		React auth flow test project	\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
ea386a21-7aad-4aa2-9971-309bc189d04f	post.logout.redirect.uris	+
bfc760aa-54e7-46a1-baaf-7b34707dc40b	post.logout.redirect.uris	+
bfc760aa-54e7-46a1-baaf-7b34707dc40b	pkce.code.challenge.method	S256
679e12fb-2ecc-49fb-a12e-27acba8c3001	post.logout.redirect.uris	+
679e12fb-2ecc-49fb-a12e-27acba8c3001	pkce.code.challenge.method	S256
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	post.logout.redirect.uris	+
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	post.logout.redirect.uris	+
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	pkce.code.challenge.method	S256
a90de389-2773-4abe-97a0-76c4097f51e1	post.logout.redirect.uris	+
a90de389-2773-4abe-97a0-76c4097f51e1	pkce.code.challenge.method	S256
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	oauth2.device.authorization.grant.enabled	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	oidc.ciba.grant.enabled	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	post.logout.redirect.uris	http://localhost:3000/*
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	backchannel.logout.session.required	true
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	backchannel.logout.revoke.offline.tokens	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	display.on.consent.screen	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	use.refresh.tokens	true
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	client_credentials.use_refresh_token	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	token.response.type.bearer.lower-case	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	tls.client.certificate.bound.access.tokens	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	require.pushed.authorization.requests	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	acr.loa.map	{}
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	client.secret.creation.time	1753333065
d2d514c2-d51d-4665-a3f7-42b3517261cd	oauth2.device.authorization.grant.enabled	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	oidc.ciba.grant.enabled	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	backchannel.logout.session.required	true
d2d514c2-d51d-4665-a3f7-42b3517261cd	backchannel.logout.revoke.offline.tokens	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	display.on.consent.screen	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	use.refresh.tokens	true
d2d514c2-d51d-4665-a3f7-42b3517261cd	client_credentials.use_refresh_token	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	token.response.type.bearer.lower-case	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	tls.client.certificate.bound.access.tokens	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	require.pushed.authorization.requests	false
d2d514c2-d51d-4665-a3f7-42b3517261cd	acr.loa.map	{}
d2d514c2-d51d-4665-a3f7-42b3517261cd	client.secret.creation.time	1753337894
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	client.use.lightweight.access.token.enabled	false
679e12fb-2ecc-49fb-a12e-27acba8c3001	client.use.lightweight.access.token.enabled	true
af677b3d-b47d-42bd-b25d-ef928d9175d1	client.use.lightweight.access.token.enabled	true
a90de389-2773-4abe-97a0-76c4097f51e1	client.use.lightweight.access.token.enabled	true
5463855b-8b8d-4ecd-8385-3503cafa2acf	client.use.lightweight.access.token.enabled	true
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	realm_client	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	standard.token.exchange.enabled	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	frontchannel.logout.session.required	true
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	access.token.header.type.rfc9068	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	request.object.signature.alg	any
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	request.object.encryption.alg	any
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	request.object.encryption.enc	any
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	request.object.required	not required
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	client.introspection.response.allow.jwt.claim.enabled	false
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	access.token.lifespan	900
412c16a0-f717-40d0-a0bf-1394aa071e3f	post.logout.redirect.uris	+
4655a990-3381-45fa-9109-61cf86c04435	post.logout.redirect.uris	+
4655a990-3381-45fa-9109-61cf86c04435	pkce.code.challenge.method	S256
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	post.logout.redirect.uris	+
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	pkce.code.challenge.method	S256
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	client.use.lightweight.access.token.enabled	true
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	client.use.lightweight.access.token.enabled	true
eb655986-9bbe-4fee-989f-f414bce735ff	client.secret.creation.time	1754035920
eb655986-9bbe-4fee-989f-f414bce735ff	standard.token.exchange.enabled	false
eb655986-9bbe-4fee-989f-f414bce735ff	oauth2.device.authorization.grant.enabled	false
eb655986-9bbe-4fee-989f-f414bce735ff	oidc.ciba.grant.enabled	false
eb655986-9bbe-4fee-989f-f414bce735ff	backchannel.logout.session.required	true
eb655986-9bbe-4fee-989f-f414bce735ff	backchannel.logout.revoke.offline.tokens	false
eb655986-9bbe-4fee-989f-f414bce735ff	realm_client	false
eb655986-9bbe-4fee-989f-f414bce735ff	display.on.consent.screen	false
eb655986-9bbe-4fee-989f-f414bce735ff	frontchannel.logout.session.required	true
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
ebe2880d-ffbb-4717-9e76-6b5c076c23e8	offline_access	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect built-in scope: offline_access	openid-connect
286f12e9-8ab3-4afb-876a-bf6f1e53d0f7	role_list	e4ec3424-6c77-4ffb-856a-e7222a16b801	SAML role list	saml
b0789abb-cf11-4d4a-a685-7bd2226a69b7	profile	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect built-in scope: profile	openid-connect
ab54a371-fdd4-4900-b970-ee2a74aad39e	email	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect built-in scope: email	openid-connect
6cdb4fb0-31fa-46c7-b727-95b1c6843f15	address	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect built-in scope: address	openid-connect
9f5dcbde-2b85-4566-998f-89d6461871a2	phone	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect built-in scope: phone	openid-connect
7933f688-d07c-4524-939c-747e2b44228d	roles	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect scope for add user roles to the access token	openid-connect
fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	web-origins	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect scope for add allowed web origins to the access token	openid-connect
4855eb4c-982e-4de2-ac9c-08e01114e584	microprofile-jwt	e4ec3424-6c77-4ffb-856a-e7222a16b801	Microprofile - JWT built-in scope	openid-connect
6e7fa33b-8456-4f6e-9afa-b339c9244171	acr	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
4115fb85-0280-42cd-8e22-fb4e86e5291b	offline_access	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect built-in scope: offline_access	openid-connect
620340cc-1e9f-4561-b4ea-548c70715778	role_list	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	SAML role list	saml
9fa56c92-75a0-459a-8a5c-29563cf591c1	profile	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect built-in scope: profile	openid-connect
a77526c3-b8ab-4d7a-8473-d1316a9936f0	email	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect built-in scope: email	openid-connect
6043ed37-6a12-4bd5-b874-1dea2a5a8341	address	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect built-in scope: address	openid-connect
f577d598-5619-40a1-85e1-e3a8df38e6e2	phone	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect built-in scope: phone	openid-connect
7b9fe2b6-4180-4488-9dad-fa1a79240200	roles	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect scope for add user roles to the access token	openid-connect
4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	web-origins	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9899cb8b-b270-4603-b0e3-369932bb060c	microprofile-jwt	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	Microprofile - JWT built-in scope	openid-connect
d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	acr	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
e269a132-63bf-4094-aeb3-f1b1bbf197c3	basic	e4ec3424-6c77-4ffb-856a-e7222a16b801	OpenID Connect scope for add all basic claims to the token	openid-connect
9c8c6084-99d4-414d-b275-be778249a8fa	basic	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	OpenID Connect scope for add all basic claims to the token	openid-connect
015070e0-f26a-4a53-8f9b-ef3114b38cf9	service_account	e4ec3424-6c77-4ffb-856a-e7222a16b801	Specific scope for a client enabled for service accounts	openid-connect
afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc	service_account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	Specific scope for a client enabled for service accounts	openid-connect
22b0b130-077d-4b7d-8917-09ecf753e097	offline_access	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect built-in scope: offline_access	openid-connect
a1bf4f05-18a4-4975-bc85-367f0120a192	role_list	e5342017-007b-4615-8c72-27d89b5f59ae	SAML role list	saml
153f5992-1222-4564-81fe-f6336a9b8889	saml_organization	e5342017-007b-4615-8c72-27d89b5f59ae	Organization Membership	saml
ae085333-9427-40f5-844d-328704f278a3	profile	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect built-in scope: profile	openid-connect
29e39219-f881-48fa-9d38-61e9ea6b2494	email	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect built-in scope: email	openid-connect
53492f80-4f4f-419b-aeb4-e96aed6b1a89	address	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect built-in scope: address	openid-connect
cc2995a7-f147-428b-8071-48ddf8839047	phone	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect built-in scope: phone	openid-connect
0386af28-96d9-46a7-848d-1e840c6ed2e0	roles	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect scope for add user roles to the access token	openid-connect
dcccf510-6455-4bc6-a5c2-dec8a0df06ee	web-origins	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9861a837-90dc-46db-a146-1b36ad389991	microprofile-jwt	e5342017-007b-4615-8c72-27d89b5f59ae	Microprofile - JWT built-in scope	openid-connect
a1ecb6aa-2575-4f1b-bc18-04e4c745692a	acr	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	basic	e5342017-007b-4615-8c72-27d89b5f59ae	OpenID Connect scope for add all basic claims to the token	openid-connect
dc68e456-9067-4f73-93d4-16cf38272005	service_account	e5342017-007b-4615-8c72-27d89b5f59ae	Specific scope for a client enabled for service accounts	openid-connect
674aae81-737f-4e4c-9211-6b29cb97c40a	organization	e5342017-007b-4615-8c72-27d89b5f59ae	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
ebe2880d-ffbb-4717-9e76-6b5c076c23e8	true	display.on.consent.screen
ebe2880d-ffbb-4717-9e76-6b5c076c23e8	${offlineAccessScopeConsentText}	consent.screen.text
286f12e9-8ab3-4afb-876a-bf6f1e53d0f7	true	display.on.consent.screen
286f12e9-8ab3-4afb-876a-bf6f1e53d0f7	${samlRoleListScopeConsentText}	consent.screen.text
b0789abb-cf11-4d4a-a685-7bd2226a69b7	true	display.on.consent.screen
b0789abb-cf11-4d4a-a685-7bd2226a69b7	${profileScopeConsentText}	consent.screen.text
b0789abb-cf11-4d4a-a685-7bd2226a69b7	true	include.in.token.scope
ab54a371-fdd4-4900-b970-ee2a74aad39e	true	display.on.consent.screen
ab54a371-fdd4-4900-b970-ee2a74aad39e	${emailScopeConsentText}	consent.screen.text
ab54a371-fdd4-4900-b970-ee2a74aad39e	true	include.in.token.scope
6cdb4fb0-31fa-46c7-b727-95b1c6843f15	true	display.on.consent.screen
6cdb4fb0-31fa-46c7-b727-95b1c6843f15	${addressScopeConsentText}	consent.screen.text
6cdb4fb0-31fa-46c7-b727-95b1c6843f15	true	include.in.token.scope
9f5dcbde-2b85-4566-998f-89d6461871a2	true	display.on.consent.screen
9f5dcbde-2b85-4566-998f-89d6461871a2	${phoneScopeConsentText}	consent.screen.text
9f5dcbde-2b85-4566-998f-89d6461871a2	true	include.in.token.scope
7933f688-d07c-4524-939c-747e2b44228d	true	display.on.consent.screen
7933f688-d07c-4524-939c-747e2b44228d	${rolesScopeConsentText}	consent.screen.text
7933f688-d07c-4524-939c-747e2b44228d	false	include.in.token.scope
fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	false	display.on.consent.screen
fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6		consent.screen.text
fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	false	include.in.token.scope
4855eb4c-982e-4de2-ac9c-08e01114e584	false	display.on.consent.screen
4855eb4c-982e-4de2-ac9c-08e01114e584	true	include.in.token.scope
6e7fa33b-8456-4f6e-9afa-b339c9244171	false	display.on.consent.screen
6e7fa33b-8456-4f6e-9afa-b339c9244171	false	include.in.token.scope
4115fb85-0280-42cd-8e22-fb4e86e5291b	true	display.on.consent.screen
4115fb85-0280-42cd-8e22-fb4e86e5291b	${offlineAccessScopeConsentText}	consent.screen.text
620340cc-1e9f-4561-b4ea-548c70715778	true	display.on.consent.screen
620340cc-1e9f-4561-b4ea-548c70715778	${samlRoleListScopeConsentText}	consent.screen.text
9fa56c92-75a0-459a-8a5c-29563cf591c1	true	display.on.consent.screen
9fa56c92-75a0-459a-8a5c-29563cf591c1	${profileScopeConsentText}	consent.screen.text
9fa56c92-75a0-459a-8a5c-29563cf591c1	true	include.in.token.scope
a77526c3-b8ab-4d7a-8473-d1316a9936f0	true	display.on.consent.screen
a77526c3-b8ab-4d7a-8473-d1316a9936f0	${emailScopeConsentText}	consent.screen.text
a77526c3-b8ab-4d7a-8473-d1316a9936f0	true	include.in.token.scope
6043ed37-6a12-4bd5-b874-1dea2a5a8341	true	display.on.consent.screen
6043ed37-6a12-4bd5-b874-1dea2a5a8341	${addressScopeConsentText}	consent.screen.text
6043ed37-6a12-4bd5-b874-1dea2a5a8341	true	include.in.token.scope
f577d598-5619-40a1-85e1-e3a8df38e6e2	true	display.on.consent.screen
f577d598-5619-40a1-85e1-e3a8df38e6e2	${phoneScopeConsentText}	consent.screen.text
f577d598-5619-40a1-85e1-e3a8df38e6e2	true	include.in.token.scope
7b9fe2b6-4180-4488-9dad-fa1a79240200	true	display.on.consent.screen
7b9fe2b6-4180-4488-9dad-fa1a79240200	${rolesScopeConsentText}	consent.screen.text
7b9fe2b6-4180-4488-9dad-fa1a79240200	false	include.in.token.scope
4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	false	display.on.consent.screen
4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90		consent.screen.text
4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	false	include.in.token.scope
9899cb8b-b270-4603-b0e3-369932bb060c	false	display.on.consent.screen
9899cb8b-b270-4603-b0e3-369932bb060c	true	include.in.token.scope
d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	false	display.on.consent.screen
d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	false	include.in.token.scope
e269a132-63bf-4094-aeb3-f1b1bbf197c3	false	display.on.consent.screen
e269a132-63bf-4094-aeb3-f1b1bbf197c3	false	include.in.token.scope
9c8c6084-99d4-414d-b275-be778249a8fa	false	display.on.consent.screen
9c8c6084-99d4-414d-b275-be778249a8fa	false	include.in.token.scope
015070e0-f26a-4a53-8f9b-ef3114b38cf9	false	display.on.consent.screen
015070e0-f26a-4a53-8f9b-ef3114b38cf9	false	include.in.token.scope
afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc	false	display.on.consent.screen
afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc	false	include.in.token.scope
22b0b130-077d-4b7d-8917-09ecf753e097	true	display.on.consent.screen
22b0b130-077d-4b7d-8917-09ecf753e097	${offlineAccessScopeConsentText}	consent.screen.text
a1bf4f05-18a4-4975-bc85-367f0120a192	true	display.on.consent.screen
a1bf4f05-18a4-4975-bc85-367f0120a192	${samlRoleListScopeConsentText}	consent.screen.text
153f5992-1222-4564-81fe-f6336a9b8889	false	display.on.consent.screen
ae085333-9427-40f5-844d-328704f278a3	true	display.on.consent.screen
ae085333-9427-40f5-844d-328704f278a3	${profileScopeConsentText}	consent.screen.text
ae085333-9427-40f5-844d-328704f278a3	true	include.in.token.scope
29e39219-f881-48fa-9d38-61e9ea6b2494	true	display.on.consent.screen
29e39219-f881-48fa-9d38-61e9ea6b2494	${emailScopeConsentText}	consent.screen.text
29e39219-f881-48fa-9d38-61e9ea6b2494	true	include.in.token.scope
53492f80-4f4f-419b-aeb4-e96aed6b1a89	true	display.on.consent.screen
53492f80-4f4f-419b-aeb4-e96aed6b1a89	${addressScopeConsentText}	consent.screen.text
53492f80-4f4f-419b-aeb4-e96aed6b1a89	true	include.in.token.scope
cc2995a7-f147-428b-8071-48ddf8839047	true	display.on.consent.screen
cc2995a7-f147-428b-8071-48ddf8839047	${phoneScopeConsentText}	consent.screen.text
cc2995a7-f147-428b-8071-48ddf8839047	true	include.in.token.scope
0386af28-96d9-46a7-848d-1e840c6ed2e0	true	display.on.consent.screen
0386af28-96d9-46a7-848d-1e840c6ed2e0	${rolesScopeConsentText}	consent.screen.text
0386af28-96d9-46a7-848d-1e840c6ed2e0	false	include.in.token.scope
dcccf510-6455-4bc6-a5c2-dec8a0df06ee	false	display.on.consent.screen
dcccf510-6455-4bc6-a5c2-dec8a0df06ee		consent.screen.text
dcccf510-6455-4bc6-a5c2-dec8a0df06ee	false	include.in.token.scope
9861a837-90dc-46db-a146-1b36ad389991	false	display.on.consent.screen
9861a837-90dc-46db-a146-1b36ad389991	true	include.in.token.scope
a1ecb6aa-2575-4f1b-bc18-04e4c745692a	false	display.on.consent.screen
a1ecb6aa-2575-4f1b-bc18-04e4c745692a	false	include.in.token.scope
4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	false	display.on.consent.screen
4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	false	include.in.token.scope
dc68e456-9067-4f73-93d4-16cf38272005	false	display.on.consent.screen
dc68e456-9067-4f73-93d4-16cf38272005	false	include.in.token.scope
674aae81-737f-4e4c-9211-6b29cb97c40a	true	display.on.consent.screen
674aae81-737f-4e4c-9211-6b29cb97c40a	${organizationScopeConsentText}	consent.screen.text
674aae81-737f-4e4c-9211-6b29cb97c40a	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
ea386a21-7aad-4aa2-9971-309bc189d04f	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
ea386a21-7aad-4aa2-9971-309bc189d04f	7933f688-d07c-4524-939c-747e2b44228d	t
ea386a21-7aad-4aa2-9971-309bc189d04f	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
ea386a21-7aad-4aa2-9971-309bc189d04f	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
ea386a21-7aad-4aa2-9971-309bc189d04f	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
ea386a21-7aad-4aa2-9971-309bc189d04f	9f5dcbde-2b85-4566-998f-89d6461871a2	f
ea386a21-7aad-4aa2-9971-309bc189d04f	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
ea386a21-7aad-4aa2-9971-309bc189d04f	4855eb4c-982e-4de2-ac9c-08e01114e584	f
ea386a21-7aad-4aa2-9971-309bc189d04f	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	7933f688-d07c-4524-939c-747e2b44228d	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	9f5dcbde-2b85-4566-998f-89d6461871a2	f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	4855eb4c-982e-4de2-ac9c-08e01114e584	f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
af677b3d-b47d-42bd-b25d-ef928d9175d1	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	7933f688-d07c-4524-939c-747e2b44228d	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	9f5dcbde-2b85-4566-998f-89d6461871a2	f
af677b3d-b47d-42bd-b25d-ef928d9175d1	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
af677b3d-b47d-42bd-b25d-ef928d9175d1	4855eb4c-982e-4de2-ac9c-08e01114e584	f
af677b3d-b47d-42bd-b25d-ef928d9175d1	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
ddad3566-58de-406b-81b8-9e3d0c170c11	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
ddad3566-58de-406b-81b8-9e3d0c170c11	7933f688-d07c-4524-939c-747e2b44228d	t
ddad3566-58de-406b-81b8-9e3d0c170c11	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
ddad3566-58de-406b-81b8-9e3d0c170c11	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
ddad3566-58de-406b-81b8-9e3d0c170c11	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
ddad3566-58de-406b-81b8-9e3d0c170c11	9f5dcbde-2b85-4566-998f-89d6461871a2	f
ddad3566-58de-406b-81b8-9e3d0c170c11	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
ddad3566-58de-406b-81b8-9e3d0c170c11	4855eb4c-982e-4de2-ac9c-08e01114e584	f
ddad3566-58de-406b-81b8-9e3d0c170c11	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
4310914d-fded-4dd2-b40a-09541da537f8	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
4310914d-fded-4dd2-b40a-09541da537f8	7933f688-d07c-4524-939c-747e2b44228d	t
4310914d-fded-4dd2-b40a-09541da537f8	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
4310914d-fded-4dd2-b40a-09541da537f8	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
4310914d-fded-4dd2-b40a-09541da537f8	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
4310914d-fded-4dd2-b40a-09541da537f8	9f5dcbde-2b85-4566-998f-89d6461871a2	f
4310914d-fded-4dd2-b40a-09541da537f8	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
4310914d-fded-4dd2-b40a-09541da537f8	4855eb4c-982e-4de2-ac9c-08e01114e584	f
4310914d-fded-4dd2-b40a-09541da537f8	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
679e12fb-2ecc-49fb-a12e-27acba8c3001	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	7933f688-d07c-4524-939c-747e2b44228d	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	9f5dcbde-2b85-4566-998f-89d6461871a2	f
679e12fb-2ecc-49fb-a12e-27acba8c3001	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
679e12fb-2ecc-49fb-a12e-27acba8c3001	4855eb4c-982e-4de2-ac9c-08e01114e584	f
679e12fb-2ecc-49fb-a12e-27acba8c3001	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	9899cb8b-b270-4603-b0e3-369932bb060c	f
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	9899cb8b-b270-4603-b0e3-369932bb060c	f
5463855b-8b8d-4ecd-8385-3503cafa2acf	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
5463855b-8b8d-4ecd-8385-3503cafa2acf	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
5463855b-8b8d-4ecd-8385-3503cafa2acf	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
5463855b-8b8d-4ecd-8385-3503cafa2acf	9899cb8b-b270-4603-b0e3-369932bb060c	f
3c61d0de-62ab-4385-b3da-03cf13a8bcde	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
3c61d0de-62ab-4385-b3da-03cf13a8bcde	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
3c61d0de-62ab-4385-b3da-03cf13a8bcde	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
3c61d0de-62ab-4385-b3da-03cf13a8bcde	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
3c61d0de-62ab-4385-b3da-03cf13a8bcde	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
3c61d0de-62ab-4385-b3da-03cf13a8bcde	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
3c61d0de-62ab-4385-b3da-03cf13a8bcde	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
3c61d0de-62ab-4385-b3da-03cf13a8bcde	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
3c61d0de-62ab-4385-b3da-03cf13a8bcde	9899cb8b-b270-4603-b0e3-369932bb060c	f
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	9899cb8b-b270-4603-b0e3-369932bb060c	f
a90de389-2773-4abe-97a0-76c4097f51e1	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
a90de389-2773-4abe-97a0-76c4097f51e1	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
a90de389-2773-4abe-97a0-76c4097f51e1	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
a90de389-2773-4abe-97a0-76c4097f51e1	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
a90de389-2773-4abe-97a0-76c4097f51e1	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
a90de389-2773-4abe-97a0-76c4097f51e1	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
a90de389-2773-4abe-97a0-76c4097f51e1	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
a90de389-2773-4abe-97a0-76c4097f51e1	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
a90de389-2773-4abe-97a0-76c4097f51e1	9899cb8b-b270-4603-b0e3-369932bb060c	f
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	9899cb8b-b270-4603-b0e3-369932bb060c	f
d2d514c2-d51d-4665-a3f7-42b3517261cd	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
d2d514c2-d51d-4665-a3f7-42b3517261cd	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
d2d514c2-d51d-4665-a3f7-42b3517261cd	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
d2d514c2-d51d-4665-a3f7-42b3517261cd	9899cb8b-b270-4603-b0e3-369932bb060c	f
ea386a21-7aad-4aa2-9971-309bc189d04f	e269a132-63bf-4094-aeb3-f1b1bbf197c3	t
bfc760aa-54e7-46a1-baaf-7b34707dc40b	e269a132-63bf-4094-aeb3-f1b1bbf197c3	t
679e12fb-2ecc-49fb-a12e-27acba8c3001	e269a132-63bf-4094-aeb3-f1b1bbf197c3	t
af677b3d-b47d-42bd-b25d-ef928d9175d1	e269a132-63bf-4094-aeb3-f1b1bbf197c3	t
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	9c8c6084-99d4-414d-b275-be778249a8fa	t
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	9c8c6084-99d4-414d-b275-be778249a8fa	t
a90de389-2773-4abe-97a0-76c4097f51e1	9c8c6084-99d4-414d-b275-be778249a8fa	t
5463855b-8b8d-4ecd-8385-3503cafa2acf	9c8c6084-99d4-414d-b275-be778249a8fa	t
d2d514c2-d51d-4665-a3f7-42b3517261cd	9c8c6084-99d4-414d-b275-be778249a8fa	t
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	9c8c6084-99d4-414d-b275-be778249a8fa	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	29e39219-f881-48fa-9d38-61e9ea6b2494	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	ae085333-9427-40f5-844d-328704f278a3	t
412c16a0-f717-40d0-a0bf-1394aa071e3f	22b0b130-077d-4b7d-8917-09ecf753e097	f
412c16a0-f717-40d0-a0bf-1394aa071e3f	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
412c16a0-f717-40d0-a0bf-1394aa071e3f	cc2995a7-f147-428b-8071-48ddf8839047	f
412c16a0-f717-40d0-a0bf-1394aa071e3f	674aae81-737f-4e4c-9211-6b29cb97c40a	f
412c16a0-f717-40d0-a0bf-1394aa071e3f	9861a837-90dc-46db-a146-1b36ad389991	f
4655a990-3381-45fa-9109-61cf86c04435	29e39219-f881-48fa-9d38-61e9ea6b2494	t
4655a990-3381-45fa-9109-61cf86c04435	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
4655a990-3381-45fa-9109-61cf86c04435	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
4655a990-3381-45fa-9109-61cf86c04435	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
4655a990-3381-45fa-9109-61cf86c04435	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
4655a990-3381-45fa-9109-61cf86c04435	ae085333-9427-40f5-844d-328704f278a3	t
4655a990-3381-45fa-9109-61cf86c04435	22b0b130-077d-4b7d-8917-09ecf753e097	f
4655a990-3381-45fa-9109-61cf86c04435	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
4655a990-3381-45fa-9109-61cf86c04435	cc2995a7-f147-428b-8071-48ddf8839047	f
4655a990-3381-45fa-9109-61cf86c04435	674aae81-737f-4e4c-9211-6b29cb97c40a	f
4655a990-3381-45fa-9109-61cf86c04435	9861a837-90dc-46db-a146-1b36ad389991	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	29e39219-f881-48fa-9d38-61e9ea6b2494	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	ae085333-9427-40f5-844d-328704f278a3	t
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	22b0b130-077d-4b7d-8917-09ecf753e097	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	cc2995a7-f147-428b-8071-48ddf8839047	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	674aae81-737f-4e4c-9211-6b29cb97c40a	f
d6f80c63-5489-49ec-bae9-d4d7aa2e8fdb	9861a837-90dc-46db-a146-1b36ad389991	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	29e39219-f881-48fa-9d38-61e9ea6b2494	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	ae085333-9427-40f5-844d-328704f278a3	t
9b7ba629-f8b4-49da-94c9-9fab7f42f014	22b0b130-077d-4b7d-8917-09ecf753e097	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	cc2995a7-f147-428b-8071-48ddf8839047	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	674aae81-737f-4e4c-9211-6b29cb97c40a	f
9b7ba629-f8b4-49da-94c9-9fab7f42f014	9861a837-90dc-46db-a146-1b36ad389991	f
40092299-0564-45c4-a3f8-ea07b2891c33	29e39219-f881-48fa-9d38-61e9ea6b2494	t
40092299-0564-45c4-a3f8-ea07b2891c33	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
40092299-0564-45c4-a3f8-ea07b2891c33	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
40092299-0564-45c4-a3f8-ea07b2891c33	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
40092299-0564-45c4-a3f8-ea07b2891c33	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
40092299-0564-45c4-a3f8-ea07b2891c33	ae085333-9427-40f5-844d-328704f278a3	t
40092299-0564-45c4-a3f8-ea07b2891c33	22b0b130-077d-4b7d-8917-09ecf753e097	f
40092299-0564-45c4-a3f8-ea07b2891c33	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
40092299-0564-45c4-a3f8-ea07b2891c33	cc2995a7-f147-428b-8071-48ddf8839047	f
40092299-0564-45c4-a3f8-ea07b2891c33	674aae81-737f-4e4c-9211-6b29cb97c40a	f
40092299-0564-45c4-a3f8-ea07b2891c33	9861a837-90dc-46db-a146-1b36ad389991	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	29e39219-f881-48fa-9d38-61e9ea6b2494	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	ae085333-9427-40f5-844d-328704f278a3	t
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	22b0b130-077d-4b7d-8917-09ecf753e097	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	cc2995a7-f147-428b-8071-48ddf8839047	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	674aae81-737f-4e4c-9211-6b29cb97c40a	f
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	9861a837-90dc-46db-a146-1b36ad389991	f
eb655986-9bbe-4fee-989f-f414bce735ff	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
eb655986-9bbe-4fee-989f-f414bce735ff	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
eb655986-9bbe-4fee-989f-f414bce735ff	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
eb655986-9bbe-4fee-989f-f414bce735ff	9c8c6084-99d4-414d-b275-be778249a8fa	t
eb655986-9bbe-4fee-989f-f414bce735ff	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
eb655986-9bbe-4fee-989f-f414bce735ff	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
eb655986-9bbe-4fee-989f-f414bce735ff	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
eb655986-9bbe-4fee-989f-f414bce735ff	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
eb655986-9bbe-4fee-989f-f414bce735ff	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
eb655986-9bbe-4fee-989f-f414bce735ff	9899cb8b-b270-4603-b0e3-369932bb060c	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
ebe2880d-ffbb-4717-9e76-6b5c076c23e8	6f86200d-177c-4fbc-9c98-f95bbe7c5859
4115fb85-0280-42cd-8e22-fb4e86e5291b	20ea1859-5ec2-4cf7-84c5-f8d272acb7c6
22b0b130-077d-4b7d-8917-09ecf753e097	23664230-7fc5-484b-8f38-79835e90b3fd
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
0dc44f66-97a8-479e-b392-030675f4292d	Trusted Hosts	e4ec3424-6c77-4ffb-856a-e7222a16b801	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
f49daa39-5298-4cfe-9568-3fbb4ec4a000	Consent Required	e4ec3424-6c77-4ffb-856a-e7222a16b801	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
653e5aac-8a24-4bf6-8a2d-1ac584a7633d	Full Scope Disabled	e4ec3424-6c77-4ffb-856a-e7222a16b801	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
8bbd4ea3-e026-47df-8f48-897bf3acba28	Max Clients Limit	e4ec3424-6c77-4ffb-856a-e7222a16b801	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
230f2bdf-e76a-4a99-8ccb-ea635505236e	Allowed Protocol Mapper Types	e4ec3424-6c77-4ffb-856a-e7222a16b801	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
fa02a9b8-a7be-45e9-9a60-4d292b613a67	Allowed Client Scopes	e4ec3424-6c77-4ffb-856a-e7222a16b801	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	anonymous
3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	Allowed Protocol Mapper Types	e4ec3424-6c77-4ffb-856a-e7222a16b801	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	authenticated
7259e70e-3587-4e86-81dd-0149860cfd54	Allowed Client Scopes	e4ec3424-6c77-4ffb-856a-e7222a16b801	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	authenticated
54a08244-7a53-4fb8-94fe-8a217d4e5107	rsa-generated	e4ec3424-6c77-4ffb-856a-e7222a16b801	rsa-generated	org.keycloak.keys.KeyProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
4ae92059-e75c-48c3-a49d-08fdc88cea33	rsa-enc-generated	e4ec3424-6c77-4ffb-856a-e7222a16b801	rsa-enc-generated	org.keycloak.keys.KeyProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
2046db13-9924-4257-8658-50e98096f5f9	hmac-generated	e4ec3424-6c77-4ffb-856a-e7222a16b801	hmac-generated	org.keycloak.keys.KeyProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
dac0bb6f-b24a-4bb1-941f-6ee6fc409480	aes-generated	e4ec3424-6c77-4ffb-856a-e7222a16b801	aes-generated	org.keycloak.keys.KeyProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
3f94a57f-1242-4bf4-83e3-c3a5c71ea874	rsa-generated	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	rsa-generated	org.keycloak.keys.KeyProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	rsa-enc-generated	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	rsa-enc-generated	org.keycloak.keys.KeyProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
5c38f05e-dc53-42e3-bb27-b6994c1c0e5e	hmac-generated	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	hmac-generated	org.keycloak.keys.KeyProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
52ab6940-7a32-4391-8907-8cd57a94cfb5	aes-generated	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	aes-generated	org.keycloak.keys.KeyProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
370c12ba-d323-4bac-806a-d79f4ab699de	Trusted Hosts	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
704c75a6-5ee6-4db6-b9ad-9fb7cb789d33	Consent Required	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
d6e089db-10cf-4a47-967c-5d62c2089826	Full Scope Disabled	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
9d4b2397-8c5f-4aff-9f07-70fc2fb1fe7c	Max Clients Limit	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
e5a333b3-203e-4408-8814-1e957589e6d7	Allowed Protocol Mapper Types	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
9750ab0f-4a49-474a-b3ab-30761b689257	Allowed Client Scopes	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	anonymous
eae31827-6336-408a-9186-f7afde4bba42	Allowed Protocol Mapper Types	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	authenticated
59b57c0a-d8a5-48c8-a03d-fad8c2e72e1d	Allowed Client Scopes	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	authenticated
f7e15a40-79f3-4d1b-9355-7564a92e0fae	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
812fcad1-29ab-4bd2-a938-14882ad8d6c6	hmac-generated-hs512	e4ec3424-6c77-4ffb-856a-e7222a16b801	hmac-generated	org.keycloak.keys.KeyProvider	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N
81aa8a02-3b77-4899-b6d6-565acefe2032	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
39c8c6a2-935b-4313-8f00-2386293a1eab	hmac-generated-hs512	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	hmac-generated	org.keycloak.keys.KeyProvider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N
182b5ce4-fc9a-47c1-bddb-f2745c895cba	rsa-generated	e5342017-007b-4615-8c72-27d89b5f59ae	rsa-generated	org.keycloak.keys.KeyProvider	e5342017-007b-4615-8c72-27d89b5f59ae	\N
2a4bd016-6d80-4927-9652-3eef90bd7ff9	rsa-enc-generated	e5342017-007b-4615-8c72-27d89b5f59ae	rsa-enc-generated	org.keycloak.keys.KeyProvider	e5342017-007b-4615-8c72-27d89b5f59ae	\N
bee2d442-c0d5-400b-b8c0-6816db08257c	hmac-generated-hs512	e5342017-007b-4615-8c72-27d89b5f59ae	hmac-generated	org.keycloak.keys.KeyProvider	e5342017-007b-4615-8c72-27d89b5f59ae	\N
5d43f435-9a26-4313-8b06-fd2a0032cca9	aes-generated	e5342017-007b-4615-8c72-27d89b5f59ae	aes-generated	org.keycloak.keys.KeyProvider	e5342017-007b-4615-8c72-27d89b5f59ae	\N
6e461823-e107-463e-aed4-2c3da773d361	Trusted Hosts	e5342017-007b-4615-8c72-27d89b5f59ae	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
c6cc9728-990b-4bc5-af55-648eab5fc66c	Consent Required	e5342017-007b-4615-8c72-27d89b5f59ae	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
8772a9e9-5d00-4a55-b347-bfe6ff807e3a	Full Scope Disabled	e5342017-007b-4615-8c72-27d89b5f59ae	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
98b4c239-64dc-4249-8a61-8b48093575bc	Max Clients Limit	e5342017-007b-4615-8c72-27d89b5f59ae	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
24e72972-7311-42e4-a2eb-c6054bb2f443	Allowed Protocol Mapper Types	e5342017-007b-4615-8c72-27d89b5f59ae	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
2d358819-ee7f-417d-8457-8bd4960b1ff8	Allowed Client Scopes	e5342017-007b-4615-8c72-27d89b5f59ae	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	anonymous
5fe34470-6823-4e93-ae6e-e9946107fec3	Allowed Protocol Mapper Types	e5342017-007b-4615-8c72-27d89b5f59ae	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	authenticated
ba2969f0-abc7-4eaf-8563-af0a7527dcf5	Allowed Client Scopes	e5342017-007b-4615-8c72-27d89b5f59ae	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
6e104a2e-c11e-4541-9557-f12d3f4610bf	0dc44f66-97a8-479e-b392-030675f4292d	host-sending-registration-request-must-match	true
0cb7c77c-ac36-45ed-98d4-473f72560273	0dc44f66-97a8-479e-b392-030675f4292d	client-uris-must-match	true
d722718f-62fa-46c3-92df-4627d39ede5d	8bbd4ea3-e026-47df-8f48-897bf3acba28	max-clients	200
ecf5a1f9-7788-4a7e-a155-daf33a0bcb30	fa02a9b8-a7be-45e9-9a60-4d292b613a67	allow-default-scopes	true
2267aa97-1248-408f-95fe-3b2d2fa9db3e	7259e70e-3587-4e86-81dd-0149860cfd54	allow-default-scopes	true
698cb2e7-fe65-440e-90ee-964fcdbfcc6c	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	saml-user-attribute-mapper
e3264e8e-c2e0-4682-a3cd-4eb1003ab2d9	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
40617586-e4ee-4d24-bb8d-7cc37185d47f	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	saml-role-list-mapper
00e82173-769b-4167-ae44-1d503909424c	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
fd28199c-35aa-4eaa-827e-80866e46831d	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
234981c3-3f86-4475-88f0-1ac0aaa65a1d	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	saml-user-property-mapper
543ad7b0-4774-4d90-9cd4-dbf3607c3bcf	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	oidc-full-name-mapper
dbe28f75-5069-4a13-bf25-798482271b29	230f2bdf-e76a-4a99-8ccb-ea635505236e	allowed-protocol-mapper-types	oidc-address-mapper
4f21d848-c32e-489e-bff7-2d718f0558bc	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b84ab364-42a5-4d3a-a709-66316ecf39eb	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	saml-user-attribute-mapper
fc3da806-06bc-4cdd-9a4e-43eb716c8d82	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	oidc-full-name-mapper
6db5e149-60ca-45e8-8b06-94ca3588b526	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	oidc-address-mapper
0da87852-6efc-4e95-b836-5b850d461c2b	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1865ff57-9d44-4666-8b09-634dfab8ad6d	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	saml-user-property-mapper
13f9d4d8-9a37-4ebf-bd3b-52bc4939d1dc	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f4d9b14c-3874-4242-a639-f6ea7c3c59df	3cf1b2ef-4bd3-4b72-a59d-cd00bb1dd278	allowed-protocol-mapper-types	saml-role-list-mapper
83cb119d-d386-452a-81e4-beb236acfea8	4ae92059-e75c-48c3-a49d-08fdc88cea33	algorithm	RSA-OAEP
6673bf44-8057-4996-b0c5-92d9844311a9	4ae92059-e75c-48c3-a49d-08fdc88cea33	priority	100
d3058c77-3420-4ca7-84e8-a4cb84d6fe70	4ae92059-e75c-48c3-a49d-08fdc88cea33	certificate	MIICmzCCAYMCBgGYOmLYSzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNzI0MDMwMTUzWhcNMzUwNzI0MDMwMzMzWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDBcG41kXsqzu2ZGhzIqGzi4+OvlusH0VCoUs1eFdNcf0sESPsoJ6dJspBVeDAJnNk2jRvAsXW5D1U7xesmNin63/ZYoqqmRsQZl4QPNg+SXIAopNoaAtzhbkGlnZfCOiJENf6+XtTE1d8tbg3FvaRTNL4z7pnaz6sxyjzAsXNfGYuMCXZZIa0Ik8dutqxrT+jcKmIHrV4sqvNDtCbCtcCvoaQvNPEuWmLBwJKi/Hy5A2GLLzBrbnXFW4+b0DXfhSpQEwRp23ksF5x9IEZPSf5JEKcQmlcCOmUNw3i9KlIDbdprF9XU8CeYHuXrMhSOOZTYWlcuU8SOOleYJRHD0mW/AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHFdfqvZY1F6R5pU3hFPTFV3R90zX4WVtb6IdSDaaIiDMeftvNMJpNsgKNooKuDJGEW4Y8a7XzDlJsnqS3zgYWyJiepdOkU4M7dkvkjc+Pz6li8tsH3dDAK7NK2LY8MK8GXTAb/KTcUBP+SqaWzQGIX9WUa8mh5/S+cGogH3e/qSWJz6A/fjMOgPwCpMLHbo1ZMwhejrxUI7OyLCSg2UOg8vFLwfE0FkAlp6jdSze93tEtstDJVYqwPkzo9X5bLQWrQ6b+b2HCmZd4yElLW8MqfmhQMQBiHrW9kTcIOmg0VX4R+w4FzHGs1MKqRzn7Gem3yTewnwmL9yxROOxAOjGW0=
f223f691-dce9-45c6-8263-7c7e3c8f9f62	4ae92059-e75c-48c3-a49d-08fdc88cea33	keyUse	ENC
f8be2723-ca92-43a4-866f-7217e682bb67	4ae92059-e75c-48c3-a49d-08fdc88cea33	privateKey	MIIEpAIBAAKCAQEAwXBuNZF7Ks7tmRocyKhs4uPjr5brB9FQqFLNXhXTXH9LBEj7KCenSbKQVXgwCZzZNo0bwLF1uQ9VO8XrJjYp+t/2WKKqpkbEGZeEDzYPklyAKKTaGgLc4W5BpZ2XwjoiRDX+vl7UxNXfLW4Nxb2kUzS+M+6Z2s+rMco8wLFzXxmLjAl2WSGtCJPHbrasa0/o3CpiB61eLKrzQ7QmwrXAr6GkLzTxLlpiwcCSovx8uQNhiy8wa251xVuPm9A134UqUBMEadt5LBecfSBGT0n+SRCnEJpXAjplDcN4vSpSA23aaxfV1PAnmB7l6zIUjjmU2FpXLlPEjjpXmCURw9JlvwIDAQABAoIBAC7R3jMEC+pAHJ0mh1n//h7qpsTsw+VoAdxD8mY35SkpvEgEvBmrg1+gozO0u/fPqXl9LP72VPaeYfRuQqzEhmOtCqzIboKBdVx2YmXmIV29Gt37jLioAbtkmuoRm1ZNCNc2tHpybJBZ7cNKtHWsoZXsGa9rLH0cL6UE/LBtIu4czek/VN++R7e/EVdfEBicrpOgrGtvbs5CFd47iZL1cjvraLFhmprH5o5+HfVc41/0v6Gj7nfKvrxy5BQS0OhgZN52w4YargxNSvCKgWWcNNMaE8YbXj/GvvVs12vS+IHt1QkMF2r1SdCXucyG5slq6CvjH3MwF04coL0oYdFUNyUCgYEA9025+sAPADl7qvJ/n3fxvkhvW/lgTAnXR9xzGMriEWTq6j+mLRZ25DEahYfXdKYsI+/V62A7aemgErW2C3RnRhac8XhsRwseQW4QdqSD8RMopovIljRD3nxFjNwL6YqaGaj0VxhTF6wXBK9/i5JZ5M2Y+jz5yBmPFMo2KYn83uMCgYEAyD3OZ1GHE3NbdOTaD1o9S/y7oMq5AKWNT5XOxYNzUUcvZsz5yjpWK6VqlLYzGcOdLBcPD++O9rrKj5y6trV+wID2KK8d/+W9Uu14T2tKWX5B8ekL4QPZpETR91O8zdMX7GIYYlcGc5ah2k48zmxsAQuhUHJIaUaR5LHyYJnb2HUCgYEAhawdusvVT+nCTsSE9019/bxpdO12f6NSGiWukNgZGg3SbIu65uQdn3prO4IRk5u+gC5DEtcRRk5hl7tgixCAQgI3Es5kuIHp+LPlcju6lbQlZOBpq8bUaI4Dif/m8HValkQcznb3cvQx/PZfmrGgpWv8JEaRPPeTv0kNvaY4aMECgYABwPjT0tT6CKKebXqzc7jht371M5FXPhv0vH0pIbOa3KK/pb/yU3x5uWMrlkTwTtRLlJAfNZvs8Ung5CCGhSRtDzQYux/qI9r6pPXOzEPEcOSm98GQ4PXBCJFGN0eKDfVBrsJD6js2O/WC8fh6Xly7zZxGFhooQeP5Os3CptZUGQKBgQCpF214nivB6tGjyWGA/ww1QmnFyDl4ce3Xw+YN3p/j13/gckqslZU/0Zc9Ynz1C6PfkrVjjRi4yV7Vj5T+5+7ri8dPr3yh0z/YsyaUAlXY/5qXB/DnGTfR0m5wLPruHV2N4HImDavJVqSifz6FXzfX/siRX6BzDM6ws3SHlFHG3Q==
57cee4d6-38b2-4132-aa30-7636e9131660	54a08244-7a53-4fb8-94fe-8a217d4e5107	priority	100
e9177420-7560-4ed8-8040-e3f5e09ab9d9	54a08244-7a53-4fb8-94fe-8a217d4e5107	keyUse	SIG
0c8c3f6b-9bfc-41d4-b0cf-c5270b663358	54a08244-7a53-4fb8-94fe-8a217d4e5107	certificate	MIICmzCCAYMCBgGYOmLSTjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwNzI0MDMwMTUxWhcNMzUwNzI0MDMwMzMxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDUvcnijNAw4XbYaO2PGVXINRl0ZnvMNKy/eeFke/iifWX0Jgkj7uUMAF8CfH1i6KKSp6S23I4Ffaj0WzqTHFDtU2oSHQXSq0Oo4AdT2GOEy8+NtJEwrJHgXPfbclQDeKMjLJD3XwvVJRb/9hMMd/sb766hOzl9rvL99LFm0guwImwfHTml6xAYKFmVPuuATeTY84yM9Fge5h8Si/+Dto9fYpNWG8loWU/buW5ypOkVX3Jk2Uzf+1cQodvjF7nwU1Lr/tn9UADj2R6nYkv+zFQSAN5zB+/Gi0blfHyGcnDuFYjG8b1WzE8B+FkMK+35zycIp9YQWoEhBDAAsUP3RVCzAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAFs2QpInbVHtLXqvfw0zMIqlPldyiXBEGhbNGlIgFYceOfg9sv3nUIBrX3xs9qcA/4xCJMqLjhKrkdbSVPF9UWw9qVfBSwHEhh4Dtea3hsnpuMVR9KXiL3u7nqpos+XveSMkzqizdGex1EAejyvw11T2q85T9JJq3rM6Dn83+xMBAlEElzpwNlFtp/8dNyehBFIVQ2xsTTRTTjarLsPdiu96YpU8wPiu/J0zlb63kRSuqr1jrTZCWgAP8NRS8zw2KlN0wHNpyGX3/B4liCsq5MF58xI2y56OJwfsj3wIFVmAa2G8DUxvNpcVw6m3zcu7/nu3e695dfrINzfaL5zgdFo=
29624ad8-5b7f-40f7-8b70-9ea09f92143c	2a4bd016-6d80-4927-9652-3eef90bd7ff9	priority	100
f4949b32-b7a8-4465-971b-54fec4680971	2a4bd016-6d80-4927-9652-3eef90bd7ff9	keyUse	ENC
7cfe1de8-b301-47d5-a3d0-046e92664344	6e461823-e107-463e-aed4-2c3da773d361	client-uris-must-match	true
c9e723a8-b9e0-4907-8a6b-407dc6dcdafc	6e461823-e107-463e-aed4-2c3da773d361	host-sending-registration-request-must-match	true
f0cf7356-25ac-47f8-86cc-3b565a72af3c	54a08244-7a53-4fb8-94fe-8a217d4e5107	privateKey	MIIEpAIBAAKCAQEA1L3J4ozQMOF22GjtjxlVyDUZdGZ7zDSsv3nhZHv4on1l9CYJI+7lDABfAnx9YuiikqekttyOBX2o9Fs6kxxQ7VNqEh0F0qtDqOAHU9hjhMvPjbSRMKyR4Fz323JUA3ijIyyQ918L1SUW//YTDHf7G++uoTs5fa7y/fSxZtILsCJsHx05pesQGChZlT7rgE3k2POMjPRYHuYfEov/g7aPX2KTVhvJaFlP27lucqTpFV9yZNlM3/tXEKHb4xe58FNS6/7Z/VAA49kep2JL/sxUEgDecwfvxotG5Xx8hnJw7hWIxvG9VsxPAfhZDCvt+c8nCKfWEFqBIQQwALFD90VQswIDAQABAoIBAFb3itsxIz6IPNQ0+MAh5D5m7pP1/S+6bNANnAU+5KJQTuhi0CO/WiTw1eYnS/6uCR+Ypq4WNXyrJPFXhfdzgOWzzs2+zY2Uc6FKi9RLxksYIi3UnfHe6fdlKfGsqAmPPGl5o31sfmLQublDOABF4AJIlgPVOShW54DHkentfdevS76T+AYVIrDA5t+lH3nKTlXe+GC71sdfktSY8mmjGO0hXCpMUlc8Tj1rkVWHfuyCCEMYj/WBaAbfQtBB4SJxUQ6UcyTml6BtVSR5xPCXZCqJj5uhgJELAxe7C8K2u4v2qVVcPBYS+ZEa83gJvzjUDl00gKzih0vDjgoyC8eTXakCgYEA8rqYdtmbAwwqRDaB2d2tp5Tzui2mb5pLyAM5saIbMcpCZEIrXPep93jJhiojKcHdRQrJn8nCGyADJAZo2/hHDYMtoITvTT6e5bJuwHz4NHTxlvAdufKazs0A647dW5+obMXpjeKq/sQFM5g5jfe8nWvjwpRM2qePUbiaUegqVuUCgYEA4F93bOJzfom3qdPtNUSyrh0f9FDpaKKpNNcUjBnMMEJEh63kUf6zjf7CeTqYgQ2mJ9ZLFPG/Ny273/iKRof3wDUeEnFC7nWCBrdUQG0x+rrsThVtcWG8lO1H+zT2OyE1NQoCN++YcdQguGWN4L4+xJOYDiiTMgxOWia4n7ueN7cCgYEA4SAPqKvLCdiOmxWy+c6Q8Y1FQLh2VaxV/PyA1i/z6Qoe6b41WdSa39w3jSgn1OLpxs9qkbkfPulCAHexadOskuvHtcmV6Z7a4U/NSNqfmoecStIJwB0zV/rrj47B3+kE3V3ycJZ64jAMYv4c43+SgK9AX4gMgABI/RKqjq02F8ECgYBWyPZDem+bwR72JE+66+CE8iT69hTh8RCrrIl5Cz1saSViqYMHqBHBWYnVJDH6sNHU1NFjv4HrkNf7cIHjeBH/GUyRa5es7myltmFzLglH5uch6K3VTi2IGSNfagPXqSeQZVeoVRdM5/Tj/fvbsxpKJKCK0Wzlzda8jf+ZYRN4jwKBgQCdlSnkphGFG8mlBmmLTiaC4DQxmxubXG3v1iOS9+TGZwbxnZ15gZNwdWFQ6APMvXd7d7eZ4png5hXo3hVKCTHYMWKwUtGc8G9ZMTtmPaIPyyGuYxXed6iL/f4pwQ6CXjOszUArvhO+oLg2tHxtlVB6AxDNEgTHQRhUP+mcd0q7ZA==
b032c874-cc98-46a4-afce-02efa8b07812	2046db13-9924-4257-8658-50e98096f5f9	algorithm	HS256
841026c4-75e1-4c6f-bc52-c367b6e6d630	2046db13-9924-4257-8658-50e98096f5f9	secret	q4H9UfHoN4pKiOAsa_suHpCbRMECS0_f3RahrHU2zu1xEudgoaNAiejrLtZgHHZx5n3guNYtN6WgefFq8Un6RA
1a013543-7452-4786-836c-e40dd5b9fb0a	2046db13-9924-4257-8658-50e98096f5f9	priority	100
a48771d2-5a29-4b0e-ad8a-f2dbbc6c8d1e	2046db13-9924-4257-8658-50e98096f5f9	kid	6833bc13-69de-48bf-bac1-ea76064a8d3b
ff88823b-35fb-4ecf-bc98-b2250a5d86f8	dac0bb6f-b24a-4bb1-941f-6ee6fc409480	kid	e8028fed-8360-4d01-bf20-a2b09e2376e6
aef03c0d-ea9f-48d1-a075-a2e0737a4db9	dac0bb6f-b24a-4bb1-941f-6ee6fc409480	priority	100
430ad36c-2bb4-4a9c-8b49-2b8c11629af7	dac0bb6f-b24a-4bb1-941f-6ee6fc409480	secret	G6VDB_KJFk47amiAiBvIog
5026461f-4180-4012-8f6a-7d7507d890ee	3f94a57f-1242-4bf4-83e3-c3a5c71ea874	keyUse	SIG
d1093c77-ef46-451d-ba54-7f276e442e5b	3f94a57f-1242-4bf4-83e3-c3a5c71ea874	privateKey	MIIEpAIBAAKCAQEA5h9eCYa78I6eyarNapOmg9/eNjFYAV6eD0tlp7gOBvtGsWh4/+2/t7PgNPiVqgcYiey/pDvqgR5W1f9uKgEwiptiiad79EuetA3+EAeIXGbxGeVERJA3ftWEap7UhelnjXrpR4Qgv70GC+B/l7XAT0Gx6TUU1cCKZKvH8UqP+HqLk0GLtgSLdaavfa9Xi47nXfQq+SqLRbZtEZFF2CDPDXLjtEIhlVUuRQzyxSLkRn5l7ZLx2PBwe2/rbbtC7gtUMLGt8vMO95TI2VPpaoZXlxkoTatlQt0bDm+qxfahCh8T6yxIsvxzCw0y/RXzSVaOvdOjEXa6pmIdvI9AZGXPtwIDAQABAoIBADRrts8yuwM8ad2EpBCAG/F0gLkVmneNZzISudBv8/oRKXRmWRHrxb2CIzPN4MH/pc5dePZfk7bgA2XyLtUwui8I4HR9C5aF11wqx9I89QofhRKiEGAR/iJNX0GudrkehzFKa3OYHKGw3Hy+IjKb+3fSfkWiiuF6X8w4+W30z0EJsrqJpJqITzuP2fv6MS6GGzRLFP6I82snoynANqvvOAIgy1DXe+Eyqh3qc/hDMUNAGBIAYMQ70jaAyTe6U5ZCvFzo1RIL4puyEXYp4y/QN92S5fWCMZuecOkOpKhZv14gkQDC9Ip3YwBNLHn1oEcwt8f9opXPnP3SdbRQ8g0NQykCgYEA+g6JpAbyu9DsO7n12t1PJyGDUr4qRRjVO8erg2zMoEieeNHlFzm/vg5fLrl+5eir/CWQipbhO7MQfEhHYTDVRrqPGQwlBD/QzbKJqBird5bc3WqCUFSP7WPuJ/jLuFQE2wSSPUM5TR5xjOXmqBt2pX0lBAi9UA0o98pE0rDXMcUCgYEA65eKUtrVE9e1F7wtLkS7xMpiuiAdPNPzNZ7TAnbATP6arFOcdTp/CbGi2DdY/0SKNx/8uzzWHQcDizD729SG00jye3kyWHBiec0rZEFIgbD/2rvJU4YPGBpIe22Pvj0BbJzvc+2g7iFrmrgh7nJlwB645mmxHsfOYHVtHL8b/0sCgYBEzw9NFaRhzmHTJZ7jtRZ83Bn5AN882FKE+rLVnXDJgnIpKQjzVS7QK8BBaUXkGhyJbATUPiSIewPET1dlBT0LE3chG1hsTOs2TzTWDsPQSrFINHDbjgl095SnZy0X8fbMFfvv47m24PO6I+FOzQ/fBgrTi1wc1SI63WwG1ibBSQKBgQCQhX7SQvHRYVLzA3nH11xEZU7ZFNg6t16L9ylEaqqe0NT7f7ML6t2Bidn2v0U2Gsqa9GFqTvCeD+5plZv7B83JkQdHHVr4C8EtLOJAdxfOj1D00pu3RBbAV2c9aEF0lyHnigIOYKiHTDMhT3FpP/4RNAeDOTTxR+rfG0nbB5VaLwKBgQC67M1elal3J+oBgyQqa/TTQZnKXX+iH63ZRHAdW4CJOR2skWvAQVqN8ZUr8utm1twH4WrOsjzdqmU3nI4ScXwcD1SZden0udBZCGQgQ2zizZXfCDdKsVHItnNp1l6c7VCMCpyc/s+i3+A1IqSprqMa3RyK9tIWCnXCGI6R+nrRXA==
35ab57c3-3a99-4e36-a142-bcc97e2043be	3f94a57f-1242-4bf4-83e3-c3a5c71ea874	priority	100
9066949b-e1b4-4109-8c0b-4499a95172a1	3f94a57f-1242-4bf4-83e3-c3a5c71ea874	certificate	MIICqTCCAZECBgGYOn7ToDANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1rZXljbG9hay1kZW1vMB4XDTI1MDcyNDAzMzIyN1oXDTM1MDcyNDAzMzQwN1owGDEWMBQGA1UEAwwNa2V5Y2xvYWstZGVtbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOYfXgmGu/COnsmqzWqTpoPf3jYxWAFeng9LZae4Dgb7RrFoeP/tv7ez4DT4laoHGInsv6Q76oEeVtX/bioBMIqbYomne/RLnrQN/hAHiFxm8RnlRESQN37VhGqe1IXpZ4166UeEIL+9Bgvgf5e1wE9Bsek1FNXAimSrx/FKj/h6i5NBi7YEi3Wmr32vV4uO5130Kvkqi0W2bRGRRdggzw1y47RCIZVVLkUM8sUi5EZ+Ze2S8djwcHtv6227Qu4LVDCxrfLzDveUyNlT6WqGV5cZKE2rZULdGw5vqsX2oQofE+ssSLL8cwsNMv0V80lWjr3ToxF2uqZiHbyPQGRlz7cCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAAj9JXFWLj2raQgIxiUvLyNHy2E+Ouad1JEULYWFWyQjpdHZLONIBFmmg/R+dBjTyGSYV3xkMLa78QkrPPrP4YQ0k9cPOMziLIvx58Brmu2KxAtFoNZPrEDOGJB3y/bJ8cslOCUVjwNhMGKICRJKoCYWkgZR456bMBwnc984VrouD0woNi9q2pnN6+9DB48f78wVZZA/cKgaMM5pNe2wXWeNwAZOdAU1WcjlD8ru5/1J6ZCgYNmrYzvY3qmM9HFESj7ONyNLVaZKbEeE3sBWzPAjWiKDCx1OBhnahlzU8HDASe6XTyqKNH7fJarxQrddKOCY9hopOvz8Ilpot2PxUFg==
f4e4c317-9279-4b08-857a-d7780e898918	5c38f05e-dc53-42e3-bb27-b6994c1c0e5e	algorithm	HS256
d44e2f31-d14a-45a5-ae28-2572b55dcb6f	5c38f05e-dc53-42e3-bb27-b6994c1c0e5e	secret	KmdBaW9r9z-Tdl5qsm7GVRnXphjMsLYpUdXZ9KHVOMFwxXbAFtVZTUE2mMsJAO_u4T8e7Z0WWxbriMFsFLib-w
10460215-0524-4a50-ab77-417b199b3110	5c38f05e-dc53-42e3-bb27-b6994c1c0e5e	priority	100
2d28be19-c7ed-4270-91fd-ffa4b1db4f3a	5c38f05e-dc53-42e3-bb27-b6994c1c0e5e	kid	1a84a71e-94ba-4d7a-a517-fab879f4c93d
376d5c50-c75d-4fdc-850c-01a649c4d505	52ab6940-7a32-4391-8907-8cd57a94cfb5	secret	cwJIjLBS1Bb-eTypz55iQA
9749a0c1-d917-4cbd-9160-7886758da722	52ab6940-7a32-4391-8907-8cd57a94cfb5	priority	100
7c94b12d-a41d-4be4-b162-4e835b67dc7e	52ab6940-7a32-4391-8907-8cd57a94cfb5	kid	8f5ef370-720d-4f18-b565-73dd2a87444d
1fcf9683-f280-40eb-b3dd-2572f0f3288c	2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	certificate	MIICqTCCAZECBgGYOn7Y6jANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1rZXljbG9hay1kZW1vMB4XDTI1MDcyNDAzMzIyOFoXDTM1MDcyNDAzMzQwOFowGDEWMBQGA1UEAwwNa2V5Y2xvYWstZGVtbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALU80y2EeTyOH9CCy2sXlmBVO/genq10IqfW1Ni/zYFRmRR8Gsy6n/r3y8TVSlqCBm1lQZePl7tVcWZVv2IOcFJ6PmooOKz2opraIVhCXp0TZeT77jJdOeZcuAI1DnaBAS06ggW25cz1pUXit8nRniuZnmKQ/xxa3f8x7UxPZuKr+vwKqhLzOEduIqZItSTSf9F7wwoLgrcTBwJMhNBm7FphV38q457/UIQnSX01TOHetLU1tXb2+Kr30N3YTm29cLsaSwYJwZsKRWnMx+co98n8SVUilzuyqkAD7mLJiUREHeipN1r6qVmIgGPUh4P05hRCxoHz1CXdbbqMNWEwCPECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAM67E5hGSB94OYhcDjQblf7j8xPBUtNcoQBFGimaPiYpeyLxQ++a2It030mh0ttZlJatyQrgg2qvhiiiqL87FMgYMxmFzGbGjGsxJqmXgZsB8TxpWxO3bLCL9BBtv/0dmjXcxZyOhYnE+sXOKT31ObIEodrg6szzEuuoOc3vY4t4tnsys/uXK1ZLia+u6xMrymoT2Yfsz8Pw7LT3w7hP+e+jTFWb28DAP1nR/VB5Mc4ki3B31GQ9wvNlPQXdRPvKrAEmXvHoO+mpec6+mNwyRgvaJGKVTSN2IItQNqmE0BUCbi5MPg8COyVrCVO53YamFYZpA65hpGA/WGzzNOwW80g==
31818d06-9580-45c8-8456-62366006e09d	2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	algorithm	RSA-OAEP
a53919ec-0e75-4595-8946-be0958b9b6ed	2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	priority	100
4af3efe9-01c1-4d40-8405-5ebbce99f873	98b4c239-64dc-4249-8a61-8b48093575bc	max-clients	200
aff28c2a-aaeb-4c6e-aebf-74b469f42884	2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	privateKey	MIIEowIBAAKCAQEAtTzTLYR5PI4f0ILLaxeWYFU7+B6erXQip9bU2L/NgVGZFHwazLqf+vfLxNVKWoIGbWVBl4+Xu1VxZlW/Yg5wUno+aig4rPaimtohWEJenRNl5PvuMl055ly4AjUOdoEBLTqCBbblzPWlReK3ydGeK5meYpD/HFrd/zHtTE9m4qv6/AqqEvM4R24ipki1JNJ/0XvDCguCtxMHAkyE0GbsWmFXfyrjnv9QhCdJfTVM4d60tTW1dvb4qvfQ3dhObb1wuxpLBgnBmwpFaczH5yj3yfxJVSKXO7KqQAPuYsmJREQd6Kk3WvqpWYiAY9SHg/TmFELGgfPUJd1tuow1YTAI8QIDAQABAoIBACxnh7IaR/3/MGpM8Xv+nnhhybyj++qxjqAisamdbMNnc6MiOQq6GuJJfiJuw7XjL6Hz8hspMlrSt2MEVUy4DusWSl6GFkTCdNqN4SeXs0i27PsqgpTSZJI9W1QnHbEJMHmdYSf3RNxvvxudTbxj4GX8UGMD9Y1D8ipJWEOfHK0iXlphperTKU0N8AELFl01+v3emDpLHN9LBTosr0E2/one2XPTfeM1PwknjQGgFJwlUN6yatBwTYBFG20/rt5AqsriFSiWJZxsr6tkOmqi7qjvV/PjmtGrc1I6AdE2dFU9jjeGwtnKPIzuTF6oQpZaetFG1MYwcph0VnM4c1Y+qvECgYEA3Kb91liUa8RiX0ee0qgcwiOE76B/GGBw8oqX5zGN3vccN1qmn0G+OTgVwoF45W3rCV67ub6GGt6bfRYVKLL/Q60SNYxKMXgrjit2zVmzQhskIJHThMSeR0RntLlT9392a/C//Fq2XpDbWXAWTd5EGLJcFlxNfBdE2ZlCGHH6kK0CgYEA0kVs/d/R07sRChgY+G+ps1nKaBGJXhp/QG+Tblm66FqXOlet5jl1qvTp37yA+uReWFJDTk79nSvd3uEL5PQIwfCJ5I0ZNWDeTL3d/kT+DR4cpyxBC/jOIAbMEfGlT4OAfaxjce66VIXD4eMKXbNy1AzyBdt+kbF5C2RpduQMbdUCgYBGUdnXs8cpSR7oqpSNIhJ4NIWrMIUQqbuVMGIUxhAmnK4bXgJ4AqWy6pLUuBplU9Bx3gUJvxRR/9uh06XOoK0FTmTdN+Z1OYz39BYaf5nHWYr77j1wtJCUudIrIF0IJVECOWmV7PrtzFB7gmM5Ubp1/HGolqYDBA9nIZaU384wyQKBgQCpbLNDZEKnfcVfAser9h0gnCrQ68BpiKQcAUsj0T0e10+e/OLr7ER5eVmwoyyx+6xhMfd1c4Q6Tgw5988jrdYYnn4dH+u97M1xvFLQ/DpPy4F+2dOXl+ROPevUUYbHqMexe2Ote5O7YwTQT6YclejiH4QrYA59yigkG8Y2u82f+QKBgEaYgA8KlkcwF8JhzpS74m2kL6Ph62DZ8irvlInXUZU03TIRdYQHM6G9XfgrddMpzavZ1k90z2AyApKT1SC8/O92DmJmYV4YtvXKuv3aAWCDA8Hsr5falKF3LySgVoX+LfmX6NK90QcmqMKOBolOB/ViAOG9QGGQomVzFyFkMtKo
45d2f3ce-41e9-48ee-b14f-cca5407a30f5	2cb6386f-ccb2-49e0-b2c9-78c6524d5b85	keyUse	ENC
f278dd76-6a30-4352-b6dc-156bf34ffe5a	9d4b2397-8c5f-4aff-9f07-70fc2fb1fe7c	max-clients	200
66d2305d-fbf3-45ca-a315-ef28876bf7db	9750ab0f-4a49-474a-b3ab-30761b689257	allow-default-scopes	true
3b89cabb-c2ba-432f-86b2-1b64d1429ed5	370c12ba-d323-4bac-806a-d79f4ab699de	host-sending-registration-request-must-match	true
ada038e6-ef94-4d7d-a963-8be0c2a59905	370c12ba-d323-4bac-806a-d79f4ab699de	client-uris-must-match	true
118afaaa-8272-4fe0-9d88-85a0f2a07299	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	saml-user-attribute-mapper
ddf79116-3d30-4e84-8195-093b3535c3f6	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
80b94abb-8401-4311-ba1d-e3fd992e76a6	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	saml-role-list-mapper
97a0df74-0a40-443d-b778-abadc74624c9	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b9fe5914-9fcf-46fb-904f-ce159612f2a1	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	oidc-full-name-mapper
5d47b7b9-a059-474b-a66b-0cd123c5e733	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	saml-user-property-mapper
f1b7c321-7443-405c-9219-ce39d71a4f39	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8c3e4fe1-efaf-42b0-b1cb-4cc0ebebd1c0	e5a333b3-203e-4408-8814-1e957589e6d7	allowed-protocol-mapper-types	oidc-address-mapper
7072f817-f072-49da-85c1-a8d742f7000f	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	oidc-address-mapper
6d6a67e8-7122-4982-869d-e1f9a7884ea8	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	saml-user-attribute-mapper
96cb877e-f8ec-4331-b46e-630f85c01a55	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
75dc1ca4-3d72-490b-afd9-74f0f915392c	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
af3229ff-a980-4d4d-87e4-b8ef201be90f	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	oidc-full-name-mapper
ddf27a35-e268-4436-8b9c-7d6c4ce565e3	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f2ff246c-8617-4999-889c-73835e470a52	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	saml-user-property-mapper
62d9106e-4f97-4b8b-aa37-96a0e5dd2d95	eae31827-6336-408a-9186-f7afde4bba42	allowed-protocol-mapper-types	saml-role-list-mapper
6ee928c9-59ef-48a8-981a-f333414c9869	59b57c0a-d8a5-48c8-a03d-fad8c2e72e1d	allow-default-scopes	true
2d5c0ece-434f-446c-8477-da326b262948	f7e15a40-79f3-4d1b-9355-7564a92e0fae	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
bf4a69c5-604b-4c96-a523-fb7a401797ed	812fcad1-29ab-4bd2-a938-14882ad8d6c6	secret	jEPaJJTfiyQR0S9LOK9n6z1yVcyfY1xHEtGwm3dOWL1WDCENyhI_PYrVgJU6pogv3mWfsKaKox_mlEyDuGjGfxurgWXuGD0dWsRrW5nzfSUNT-JwXNlLhL0ZegOZdjtjsaVEzeZvi_dp1GYURG9PBS7zxOI8vxk3x4RiX_-wqeU
60e3e609-95f6-4629-a7fd-40f4822cf2b6	812fcad1-29ab-4bd2-a938-14882ad8d6c6	algorithm	HS512
17ed4fab-d502-4467-aac9-979896f3e03d	812fcad1-29ab-4bd2-a938-14882ad8d6c6	priority	100
114cff7d-60c4-46c4-8ead-815a8d7ca9e6	812fcad1-29ab-4bd2-a938-14882ad8d6c6	kid	29e7b6a3-aab2-4e94-b179-671a8b9bb153
6c415c7c-8f82-411d-9add-559c4f46e616	39c8c6a2-935b-4313-8f00-2386293a1eab	kid	b6778ae6-8714-4a48-aa82-14bac87ce272
4f073a6e-64ee-47c0-a61a-a9f6da72463c	39c8c6a2-935b-4313-8f00-2386293a1eab	algorithm	HS512
b39f11d0-9a84-4961-9f97-7e8b8414e9e0	39c8c6a2-935b-4313-8f00-2386293a1eab	priority	100
d60e4a86-3552-4267-9ba5-ebae48597dd8	39c8c6a2-935b-4313-8f00-2386293a1eab	secret	L_V1K5PGS_wLfYn7GblR6HPMA4fp7oyWSxUrf2U4-rJrfpObqUdh2KHOi46VhdcfML88qw_xk3qnT9on4aEsbF3AcYsczq2ZyOjW6zZJmxauHl8A0sTBvN2IUJSKwodVaq6lOrkccoxbH07PZsj9Sseqdy57_WDxVlQjwzwV1FE
2c9073df-03ab-4146-8012-f8ee34a941f5	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
14cf4259-912a-43d0-92f7-994249f459ea	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b55620da-9f20-480e-a614-8fd19af60207	81aa8a02-3b77-4899-b6d6-565acefe2032	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}],"unmanagedAttributePolicy":"ENABLED"}
571cceff-bbe6-4a0e-8125-e2f2463159fd	5d43f435-9a26-4313-8b06-fd2a0032cca9	secret	7Q9MI72Frfa0G9xHwqe02g
9315927b-12e0-4ff0-ade0-b8450818164b	5d43f435-9a26-4313-8b06-fd2a0032cca9	kid	e7117fad-d25f-4055-923d-fd05260f8b99
bd66f857-263d-45c6-a173-7858982fda95	5d43f435-9a26-4313-8b06-fd2a0032cca9	priority	100
917bce2d-e63f-4e77-87ed-8a519f7c502a	bee2d442-c0d5-400b-b8c0-6816db08257c	kid	59b7bf05-26e8-4a55-97c6-317ebe65510e
ca4255cf-2e7d-42bf-85f4-df46c3816453	bee2d442-c0d5-400b-b8c0-6816db08257c	algorithm	HS512
294c9a1d-e7ed-480a-98af-af0e6db230b9	bee2d442-c0d5-400b-b8c0-6816db08257c	secret	e-ua1jdlt34ZsKe6ZXwDokBt4c5xBvgP93p_f2B0gQzTgGUxy9Wt2dktcyEqdmqI4vWQyq_gBUW9neWGfI1_996D5BjqmQJwE-rKtm07MdDcFYM1xLEOipcI8UdtdsrUjv1rJTU6i6yerlELmATFdwypbtBGKswGbsxDtYdoJCw
9a01b32c-72da-427d-b791-c8ab7e323fe7	bee2d442-c0d5-400b-b8c0-6816db08257c	priority	100
a2a1ae3a-ef0e-4846-8b54-dffa7e40f1df	182b5ce4-fc9a-47c1-bddb-f2745c895cba	privateKey	MIIEpAIBAAKCAQEAtMwI6G/y470YH+232d0/r4kvwW+YEu+3IfPGZUAFHAm17HeWHnTpyyxfyqeGsUyxq2q7EF9Mzha2/OUdFXuWNM4sCh0c2NA7mfFrLQ+iZj6ntyinAWhNTwIWrGpHXSAq4V4asLVufP7mhMcWcjVKP3IIxJZb6J0JKmrHEvN2p0rMX5BH6xj1H8YA2DLGn7eg5oEgrnZDGMMfBLDKTiKflgVF4iRXS78506czDF1IcHnyTLlRMjD7I0l54nXIyhU64U8BEmqBb8+sRAhk4W7bCSTlFcXRIimTEkuPgHDUR6bOO910KJgLEvYAaod98GGu92SE62OFGmrXOW0FID/mfwIDAQABAoIBAEUhAMTzTSFkA43txI7yiG/TWiWxyClxbAn43mKHdIywb9WfMhCqLlyntmbT4G35f7Ol5ynO7pycVdJjvleg/iFptbAWSpniIO/vPcYohLVofpNLYXPp0CmGCGpbZrcGXi723uizLrBvfG/Hed8oXh/dN9oHDdRm+wKzejPWUIeNLab75wbyAPz8XL8sGp00wFxBRUBFCvyHedTGe/JN96MV03pWuc7Bqf2PmIO1jcKu611jDJpb1BrOkWgYbsl7kT+9DmQI5/li0P2OiW/SG0QFq8JdthmaRr0iLVJKQWb74avs23Y5ZMIIjJF2MEjk3pFOxGX/EipJw4mOX3pU4EUCgYEA9QLxpsOHclsvnHrXf/MGikm1TB3WhHjiU59bODRFGbrGGitxGe7RjsoBTm0ZhdsvIgew+BRMzmn0NGwrmg5UH61/CG6YUFEElJmxSKKItdNsYKVrX9K+YT91ubamZo44JkVPuauEMUdC9Pv5xPRYvyPVh7Uep8cytH94nZXd3LUCgYEAvOfS1rgXDmgeNnAYKeM3Z1xFID7PffYFRcL7YshBQ2E4k1v/5QjqqC4T5jE59+DMLKKmDyXoEpBznbZOMtyQlnDtU2ygJfN7/ZCHbroPBi/28ztnULPNp2LeJXgQ+VCKa/8hNtp23tU+QiJB1wy0vHVEBCVh0gcLL8YwfCZBquMCgYEAjql4K7IOW/fccTDV6hqH5F2mwvtcvSXmIurXIpLM6X5nezVwVblJK+tTd2bvRZGqkBYKZWjskAQBvcR+XuWY9hj/rtk2tw11rVEQeUqqb7T7lgq7yr/bOqTI16oSmgSVjTMuiN3lywvDYQKXHKdqRWGII8zCXM8QJylSAfARj0ECgYBjprdmZb5j7zDg7skQb7huYhJlLD0w6XNmlbEfLxyees7pjYK0Q7vl9EizCgzWYlPSyAppu0ltYZ5b+CvQUOJFOlU3yPnCi2tBG9kV5DjAvtS7Av9BZ1h5kII3qdrqaj5bMj9HPH+wlTU+leu9kgpV0FaNCVtM/EI+dYJmO5gwmQKBgQDwoh67b3JXOl+JMq5/zjjClk+pTsrP7HL/zwxG/f+xD5Kk06DwF6f4+cJx7cAnu6qgyfOixrkUUhzCgDyfuznEcjRqU74eQs2a8VaTkEO0k9zt1huKSF+Csn75SUm4bmoerE+d45kpDLS5IEnMjXEQ25h6Jxoa5TDOItWwe4mb2A==
e2593b93-3a43-4ea9-893f-3c57129d77b3	182b5ce4-fc9a-47c1-bddb-f2745c895cba	keyUse	SIG
f387b71c-5feb-4aea-a346-49fdf0060089	182b5ce4-fc9a-47c1-bddb-f2745c895cba	priority	100
41c34f17-c0c3-47c2-ab8c-92d4b1dd08dd	182b5ce4-fc9a-47c1-bddb-f2745c895cba	certificate	MIIClzCCAX8CBgGYX72n1DANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI1MDczMTA5MDcwMVoXDTM1MDczMTA5MDg0MVowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALTMCOhv8uO9GB/tt9ndP6+JL8FvmBLvtyHzxmVABRwJtex3lh506cssX8qnhrFMsatquxBfTM4WtvzlHRV7ljTOLAodHNjQO5nxay0PomY+p7copwFoTU8CFqxqR10gKuFeGrC1bnz+5oTHFnI1Sj9yCMSWW+idCSpqxxLzdqdKzF+QR+sY9R/GANgyxp+3oOaBIK52QxjDHwSwyk4in5YFReIkV0u/OdOnMwxdSHB58ky5UTIw+yNJeeJ1yMoVOuFPARJqgW/PrEQIZOFu2wkk5RXF0SIpkxJLj4Bw1EemzjvddCiYCxL2AGqHffBhrvdkhOtjhRpq1zltBSA/5n8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAMSiIRQgEVoWC8e8ZjQHxil4Zn9CO5R10tr+ufOyGJ/xbopQ/YLpThqy3qnDZBzhADT5AbchqtYGH3dqYHTh0YNQwybluRfPB+zOOsakEw+v2plSKKLy7t5vxFPE7cM8EcYhbFWH/Cte+2upGKyhPvk7zqqCqmZy2M0ei8RQaud8VsgXM34FuHJtZwcGIziUGSzXCKvNW49umXFqQ9LiUczInCEajDE0OCW3ehG+QXNPUmnDVidZ+15KyrlkekUAa8125CwVVGrHRm3pYvIhKcr2mz6mFjV4nwIm06D0yLRn3YLwV/RftogDcG+p//7kRYtCk5/I6Fk8fwN5ZUTUZ4g==
570c94cb-c847-4164-898d-10109bb02493	2a4bd016-6d80-4927-9652-3eef90bd7ff9	privateKey	MIIEpAIBAAKCAQEAtqhwoQHlRWCaN/I29WO1KMRzXTPw3sYsY84edmTxmUJYbGrQotKlru8LEQTX52vrxmumVDy8sP84PQSoNjazqxCA+pQwqanNvv3fumnBWu4HPn67qw6dSzatTpEY58nokjwFHrUA1pkLSBeHFSDSVdrXOd1UfkncR77/9GlVc5ZlDkqlOGrYFY00JJwXFWdelAcG53U8KU1MLY3x1VpZBmZbGYBsXoyLdHyclCK+YMtZaS1Pn9r1d0UL9oCUrC6OLLUQmZkLcjS0FdaDQ+dGAUZl1ekSaixCcNEbnUf1ZcyIEThKnnPj3uiAKMbhk+jQmh5TL/bN24F6vEL9G7tmlQIDAQABAoIBABSE4eN8b9yLfcJDf/VbZj+g/f1eNzSsxNImFq73J7AvT06dReMcpccmjF2KPT9+lKXIHw8UeZ//3mSgZXhy9wZZsXDffS36E3uypP5EdhejE1uWZ2T6cc9qt4JSyMj1Gh7KBks3oH37Av+YwQXYbOMp1TFnZzVT/R5u2u2tIuUmiI2/D31OnfE1xbcHRze010INdmTSm4V4fHzs2n7DJKKqUzN8NBF9fcIO7nulwPJG+5/T8Wxhjf1pjHLJuccvV22Zz/Ufz80WdvbFt+ZI+TrGok1Wq1BGxX5W4ddnwxot480fVHPkllw3zuYC4NQPiwneEOM2MXnXvzhG8nJK78sCgYEA2NB3xx+EW4v2QtNzEb+wWbOomOw4BWJ4HYhk5TWvXxyvQNRjDuQOxiP2HzAwEljJUzj3Ar0Mx90pAbUSY56p6rXhnqjQ9ZtCqTpgnX3yGAElT1rC2SssVlgo1L782kxZmnuidqF9HGlPm6OSgVyHbp8uJD2H8VgKmVSWG9qJ9l8CgYEA16uhgXrYOJwfIxVOPe1pxIW0Lh4pgOKvZc2SRHnHUD9xLhXSYek4yodX285mr88Nn8pPMEk3ccNF29KgxYLBOzOChxoMCfZqtN/UaJ8gkEIwneQ0FLa8Q2H5MQ/VqXKs1J4JQ5IbaiST2jdzIktuX2Aa1CEZvmHMBjXwcM3W/4sCgYB9LogpqPHTpZDu7oUet02LzSZH/QMvYLY3XvvaN0/lG3u4c6gp/dTl4/eD9F+dCDRdX6OGqj6J2xCFEtXmPMKgaJk28QOM+zLW4ITOCdzQrUCse5vKpZm41LfmdcsqAzEs97tKwVyqHce/9gZtuE3dufx7IieuWgXsl6D/vgMwAwKBgQCHLv6KAW08dqeRvw4PBRxx4XjiG2facLyObD+NimOjalDQGT+Ivb4qPJGWppZ5Bqi8ivv+ATauqT7Fng3GH8JtEEl1057OM9YIz+/9MBkiM0rz/RGkFjKFbgjbdthvYQDyOKkH4LIsYwcGFhGl4nApejz20FSpn/VZwz+WBYAJJwKBgQCYpYynodVb31p4ufbbdoIBXyWXPB45WbCnMAu4Jr2GLZ4z/yGVt9ht6oblqsnvYHup4BTTu5h9sOaOgchpchHJUYn8GZUiS0gqpLGbckaIwNHTcoUcdqHsPO0Ysgfu8ffA0ZxkQ1hsi5Sh7S6h9g5gHyzig1EE24Wbbvz+NnYqvQ==
8fc958ba-577b-4608-82f9-25fb6fd63f99	2a4bd016-6d80-4927-9652-3eef90bd7ff9	algorithm	RSA-OAEP
02b5b63b-9659-4bd2-b5dc-de200aab3291	2a4bd016-6d80-4927-9652-3eef90bd7ff9	certificate	MIIClzCCAX8CBgGYX72pSDANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDAR0ZXN0MB4XDTI1MDczMTA5MDcwMVoXDTM1MDczMTA5MDg0MVowDzENMAsGA1UEAwwEdGVzdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALaocKEB5UVgmjfyNvVjtSjEc10z8N7GLGPOHnZk8ZlCWGxq0KLSpa7vCxEE1+dr68ZrplQ8vLD/OD0EqDY2s6sQgPqUMKmpzb7937ppwVruBz5+u6sOnUs2rU6RGOfJ6JI8BR61ANaZC0gXhxUg0lXa1zndVH5J3Ee+//RpVXOWZQ5KpThq2BWNNCScFxVnXpQHBud1PClNTC2N8dVaWQZmWxmAbF6Mi3R8nJQivmDLWWktT5/a9XdFC/aAlKwujiy1EJmZC3I0tBXWg0PnRgFGZdXpEmosQnDRG51H9WXMiBE4Sp5z497ogCjG4ZPo0JoeUy/2zduBerxC/Ru7ZpUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAhoeVAh5Au1aFNWdk0H20lVm7Iy3RCPvdhS9KpzlNamW8tdJP0EGYDCfWatDhaD/oym53Z92A4m+S44LeFHVaHkvepDh7y+155uIyk1QU4cVVGkSrvZPG0W+xJ+YRNrNx/wvAnQOplwwqsg0FAUOMxeQJct1M6AGcZEbIJD0tRrDBbFZZtPdxywH8cChWvUD1KCAdh0OJ+l3hOBld8qzIIlNrkbGXpqGqMIkJ0+CHGpfkeaiBrpI2VtKHP9Q9hab/HnD5G+BIb38E2MgB5hl6oJjWivDp/dZTCgYIJn4kZ0QiOYmGrjhbU/SKFox33JTxUdhCz9O64SrFwfm9ih81BA==
4c47b8c0-bc75-4755-8e34-b30354f45eb5	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	saml-user-property-mapper
78b45063-81f9-450a-9c21-d01d8f0cb2ce	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	oidc-full-name-mapper
ca0571c3-a701-40c2-aaa6-c615134e8514	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	saml-role-list-mapper
67af826d-9a74-4fa6-9ad1-3b31778faed6	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
83bcbd04-bf5c-46bd-a3d1-5871e047825b	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	oidc-address-mapper
5bedb600-97ac-4026-9150-3dcc157a0e57	24e72972-7311-42e4-a2eb-c6054bb2f443	allowed-protocol-mapper-types	saml-user-attribute-mapper
16c1e0f4-45a7-4b16-8920-cb9ad714b67e	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
07f01575-6667-44f1-8aad-48805b5169ba	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7df7ce10-73f3-4777-a290-13e80832d4c3	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	saml-user-property-mapper
f404d635-3236-4ad4-b039-7509de44c295	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	saml-user-attribute-mapper
21fe321a-1e93-43b4-b20e-6ed4bf6179ed	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
efc8981a-fee7-4d20-b443-9030796c06e1	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	oidc-address-mapper
445da8c6-f568-426f-90ec-9a89335024c3	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	saml-role-list-mapper
1f928608-35e6-4528-9860-e49170e60f88	5fe34470-6823-4e93-ae6e-e9946107fec3	allowed-protocol-mapper-types	oidc-full-name-mapper
79852f2f-9b0b-4bf8-92cc-186f303172c1	2d358819-ee7f-417d-8457-8bd4960b1ff8	allow-default-scopes	true
202ea3ec-0bab-434f-bc6a-bd42534aaa5e	ba2969f0-abc7-4eaf-8563-af0a7527dcf5	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
0966e1a5-4d98-496b-98af-dc6700410ee8	7690ddf2-5667-4829-bb55-74106a250e02
0966e1a5-4d98-496b-98af-dc6700410ee8	2f51b2a2-da2f-4722-bb6c-b54b61b28f43
0966e1a5-4d98-496b-98af-dc6700410ee8	bf5d4e52-2d8a-4267-98eb-ede8ebcf932f
0966e1a5-4d98-496b-98af-dc6700410ee8	ca71f1bf-b276-4f5c-9932-ffd44cd7478b
0966e1a5-4d98-496b-98af-dc6700410ee8	b32bd4f1-6294-4bc4-91e8-d2f67b432693
0966e1a5-4d98-496b-98af-dc6700410ee8	f0600a99-2a9e-4a10-80d4-2964c9e5ee87
0966e1a5-4d98-496b-98af-dc6700410ee8	100aed82-bc56-4893-9882-b985e096acce
0966e1a5-4d98-496b-98af-dc6700410ee8	3ce0b936-4654-41cc-ad0c-52995b672001
0966e1a5-4d98-496b-98af-dc6700410ee8	45b39549-66d2-4b90-8e3d-940a9a948051
0966e1a5-4d98-496b-98af-dc6700410ee8	bec728b4-db23-4547-979f-151454f49ddd
0966e1a5-4d98-496b-98af-dc6700410ee8	92677f37-36fc-4d9f-bc33-f94f0c46ab43
0966e1a5-4d98-496b-98af-dc6700410ee8	096f8b13-8f50-4e2d-95de-28b84ce05e8c
0966e1a5-4d98-496b-98af-dc6700410ee8	74ecbb88-9aaf-4c8e-a279-3e7fee481a90
0966e1a5-4d98-496b-98af-dc6700410ee8	7cfbce9c-877b-4c62-b0d3-f2f7cd17cf6a
0966e1a5-4d98-496b-98af-dc6700410ee8	5cfcd980-986a-4322-bc32-189e320a3121
0966e1a5-4d98-496b-98af-dc6700410ee8	1e29aa09-33a9-45f4-8b85-5390d5c9b66d
0966e1a5-4d98-496b-98af-dc6700410ee8	01415803-a2ad-4b9a-830f-badffd9a6145
0966e1a5-4d98-496b-98af-dc6700410ee8	60dfb49b-34da-4773-b30d-83da5b321043
2473be7b-b86d-4672-ab35-740f60104cdd	3fa59c04-2edc-45c3-8900-00c29d65447e
b32bd4f1-6294-4bc4-91e8-d2f67b432693	1e29aa09-33a9-45f4-8b85-5390d5c9b66d
ca71f1bf-b276-4f5c-9932-ffd44cd7478b	60dfb49b-34da-4773-b30d-83da5b321043
ca71f1bf-b276-4f5c-9932-ffd44cd7478b	5cfcd980-986a-4322-bc32-189e320a3121
2473be7b-b86d-4672-ab35-740f60104cdd	f180dae8-97ce-4577-8cb6-374b6988f96f
f180dae8-97ce-4577-8cb6-374b6988f96f	14eb4d0e-e2d6-4fda-9cf2-10e78565df67
0a1a1310-bb6e-4704-a5e4-613129bd1d62	c413fa3d-929a-4dd2-83c8-9ffcaa22c776
0966e1a5-4d98-496b-98af-dc6700410ee8	e784c038-1247-43ca-82f3-ced02977871a
2473be7b-b86d-4672-ab35-740f60104cdd	6f86200d-177c-4fbc-9c98-f95bbe7c5859
2473be7b-b86d-4672-ab35-740f60104cdd	dadd6e76-0159-4ddf-958d-76f89722f6dc
0966e1a5-4d98-496b-98af-dc6700410ee8	9b092492-d20d-48f3-9da8-0971a5e273c6
0966e1a5-4d98-496b-98af-dc6700410ee8	eff37a25-5ef8-4446-8934-6fbe06e9ec24
0966e1a5-4d98-496b-98af-dc6700410ee8	6f419259-a1f0-49d0-b50b-e3f963f63179
0966e1a5-4d98-496b-98af-dc6700410ee8	e546fdad-2fa6-47c9-8e1f-1f92628ffc0c
0966e1a5-4d98-496b-98af-dc6700410ee8	4d372846-d1b7-4842-9dc6-feeab3434b62
0966e1a5-4d98-496b-98af-dc6700410ee8	f737adf3-f98b-4a5a-86fa-faf20d29ff59
0966e1a5-4d98-496b-98af-dc6700410ee8	c21991ce-1f25-4828-a235-2de2c8e8ae07
0966e1a5-4d98-496b-98af-dc6700410ee8	88185748-e992-4c6e-aff5-66c41ca49a4f
0966e1a5-4d98-496b-98af-dc6700410ee8	a966416a-55ad-47ac-bea6-fd12e960863a
0966e1a5-4d98-496b-98af-dc6700410ee8	a5f74c3f-f435-4dc7-b38b-feaa32ce7eec
0966e1a5-4d98-496b-98af-dc6700410ee8	45785aee-f8a2-4f77-86aa-93cf14b4049d
0966e1a5-4d98-496b-98af-dc6700410ee8	1ac0a4b2-4162-429c-a899-07ad3ea77ad0
0966e1a5-4d98-496b-98af-dc6700410ee8	e25a72eb-9790-475e-824c-61dc30bb7707
0966e1a5-4d98-496b-98af-dc6700410ee8	41544d4a-f134-4af1-bef1-6d9c3b6da9aa
0966e1a5-4d98-496b-98af-dc6700410ee8	de1efcfa-887a-402c-86e2-5b5a9f559539
0966e1a5-4d98-496b-98af-dc6700410ee8	249d4db0-3e7a-482a-9cca-ea7f844fb8ba
0966e1a5-4d98-496b-98af-dc6700410ee8	35832e74-96e6-41c0-a744-066d7c898ebf
6f419259-a1f0-49d0-b50b-e3f963f63179	41544d4a-f134-4af1-bef1-6d9c3b6da9aa
6f419259-a1f0-49d0-b50b-e3f963f63179	35832e74-96e6-41c0-a744-066d7c898ebf
e546fdad-2fa6-47c9-8e1f-1f92628ffc0c	de1efcfa-887a-402c-86e2-5b5a9f559539
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	16127ea9-c56f-4c07-b46e-c7594ed5f995
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	798728d0-ea20-4b9b-a2b9-de03d16d2b90
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	a65a03fc-4acb-4a04-8d12-425140b2ffed
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	6dad1452-1624-4ef0-8ac7-5d39661295b1
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	5622ec62-baa5-4573-af5c-d3f518d6c18c
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	2f3f2847-dad4-4257-8974-73585a389825
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	1ef22544-3d92-4691-9ea6-4e532190af64
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	11a38bdc-8788-4999-a336-50cdee071674
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	07a420e6-ac7f-466d-8d96-48509f5116d6
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	9f97728d-aefe-4ca9-9059-c3644ad415a8
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	a163ed07-90e7-4a6c-9431-d6a908573d7d
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	f80993ac-fd6d-40c4-8444-50856c046eec
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	35aa2fd1-ec7e-436b-aa80-51c4d039267e
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	067fabf5-6ed3-4423-bffa-57efc7377959
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	53b3883d-bb50-4d93-b5f2-e0d7bf762f57
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	dc07b3e6-5479-4e7c-bdc7-ddfa648a8d67
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	c965f53c-cf5f-4e07-92ab-7f1faf498be2
6dad1452-1624-4ef0-8ac7-5d39661295b1	53b3883d-bb50-4d93-b5f2-e0d7bf762f57
a65a03fc-4acb-4a04-8d12-425140b2ffed	c965f53c-cf5f-4e07-92ab-7f1faf498be2
a65a03fc-4acb-4a04-8d12-425140b2ffed	067fabf5-6ed3-4423-bffa-57efc7377959
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	79f5f91f-6637-4eb8-88ea-da262bd17796
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	d7582648-81b4-4fe0-8589-09c245142f21
d7582648-81b4-4fe0-8589-09c245142f21	0bc249da-ef33-42dc-b1b2-cafd7d342f41
2893cbc8-17dc-4b24-9fab-83796e11fe55	a0ab7d05-a4e6-40d2-8cb6-7b960c89eb33
0966e1a5-4d98-496b-98af-dc6700410ee8	bc3ccf59-175c-4e9f-973c-9c8c89af08af
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	be060e3a-c393-429d-aff0-c3a3e9cdf142
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	20ea1859-5ec2-4cf7-84c5-f8d272acb7c6
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	3ac9f814-6a94-4afb-b743-d6ad10aa222d
0966e1a5-4d98-496b-98af-dc6700410ee8	6699d2ed-6b5f-4926-b9c8-87d056ed30e5
0966e1a5-4d98-496b-98af-dc6700410ee8	bbf78ce9-235a-4d46-bd65-377a97ce228e
0966e1a5-4d98-496b-98af-dc6700410ee8	2d849959-17a6-48bd-80eb-a5de3e41bd24
0966e1a5-4d98-496b-98af-dc6700410ee8	f7cad76c-7c0e-4dae-b5cd-704717e1eb51
0966e1a5-4d98-496b-98af-dc6700410ee8	30091970-3a84-4f82-b383-6eb5d333840a
0966e1a5-4d98-496b-98af-dc6700410ee8	548d25f9-a3b8-46c4-94a0-4624b8519c8c
0966e1a5-4d98-496b-98af-dc6700410ee8	04df4071-dc94-46ae-b71a-f12f0db690c8
0966e1a5-4d98-496b-98af-dc6700410ee8	9c6bced4-5ccb-4543-80f6-8ef721aaf859
0966e1a5-4d98-496b-98af-dc6700410ee8	66910cd2-625e-44c4-9135-43719cd645be
0966e1a5-4d98-496b-98af-dc6700410ee8	1b3c8bcb-8bde-464a-bd89-c19afc00da2f
0966e1a5-4d98-496b-98af-dc6700410ee8	c5ab4dcd-7571-4711-b810-54a6deab92f4
0966e1a5-4d98-496b-98af-dc6700410ee8	977fc85c-e51b-4471-b3c3-dea23e3d2204
0966e1a5-4d98-496b-98af-dc6700410ee8	bf8f9040-4d65-49e7-a76d-dddb6d01da78
0966e1a5-4d98-496b-98af-dc6700410ee8	4168cb51-a54d-4b14-a085-ceae3e722fb7
0966e1a5-4d98-496b-98af-dc6700410ee8	866010dd-9930-43ab-827c-04babd3d4a47
0966e1a5-4d98-496b-98af-dc6700410ee8	c7847e1f-8223-41fb-925a-1000eb98c5db
0966e1a5-4d98-496b-98af-dc6700410ee8	06bf1cd9-ffa8-4fc5-b848-91daacd9a0ce
2d849959-17a6-48bd-80eb-a5de3e41bd24	4168cb51-a54d-4b14-a085-ceae3e722fb7
2d849959-17a6-48bd-80eb-a5de3e41bd24	06bf1cd9-ffa8-4fc5-b848-91daacd9a0ce
f7cad76c-7c0e-4dae-b5cd-704717e1eb51	866010dd-9930-43ab-827c-04babd3d4a47
468d15e2-f793-4bbe-af49-1982bfdff43f	8f569230-e0a7-4a31-b264-cca1e6b03dd0
468d15e2-f793-4bbe-af49-1982bfdff43f	ee90de94-3dfe-41b9-b63c-db165ccb35d4
468d15e2-f793-4bbe-af49-1982bfdff43f	e25de322-c671-47f0-a954-9f72745a9157
468d15e2-f793-4bbe-af49-1982bfdff43f	fb0fc8f8-3038-476d-ae31-c529b8990840
468d15e2-f793-4bbe-af49-1982bfdff43f	a6304443-920f-4e73-a42a-dbd02b889a50
468d15e2-f793-4bbe-af49-1982bfdff43f	b5ba2d48-25c5-44b0-ab63-3c043ab5e9e6
468d15e2-f793-4bbe-af49-1982bfdff43f	30db83ba-bbc6-4b25-bf5b-6558a973df41
468d15e2-f793-4bbe-af49-1982bfdff43f	f0053d95-6db5-4055-adbb-af31ee100a60
468d15e2-f793-4bbe-af49-1982bfdff43f	8205642c-971a-4051-943d-d12ed2565656
468d15e2-f793-4bbe-af49-1982bfdff43f	d614705f-210a-4a63-8e55-5a0dab18c2d9
468d15e2-f793-4bbe-af49-1982bfdff43f	3f8d83df-cae3-4af0-9fe9-b33102e04935
468d15e2-f793-4bbe-af49-1982bfdff43f	0f9ac804-f51f-442b-a155-826731bf13e4
468d15e2-f793-4bbe-af49-1982bfdff43f	62e82157-76c5-43c4-9b5d-a015a61f3667
468d15e2-f793-4bbe-af49-1982bfdff43f	adb5a988-97a3-44b2-8301-c603cde67490
468d15e2-f793-4bbe-af49-1982bfdff43f	4fe0d3df-261a-464c-b00d-d68f96cbfdef
468d15e2-f793-4bbe-af49-1982bfdff43f	e1fd4f04-16b1-433b-85fc-4f64e7ca0a5f
468d15e2-f793-4bbe-af49-1982bfdff43f	9bfdf199-3fbd-4b7e-989d-7d8384cf5421
e25de322-c671-47f0-a954-9f72745a9157	9bfdf199-3fbd-4b7e-989d-7d8384cf5421
e25de322-c671-47f0-a954-9f72745a9157	adb5a988-97a3-44b2-8301-c603cde67490
e53032e0-bf49-4045-ad88-32e8f799d849	518525c9-d0f2-409c-a76e-68cdbbfbe868
fb0fc8f8-3038-476d-ae31-c529b8990840	4fe0d3df-261a-464c-b00d-d68f96cbfdef
e53032e0-bf49-4045-ad88-32e8f799d849	07a2b7ca-eca1-41e5-b33f-603274936e7d
07a2b7ca-eca1-41e5-b33f-603274936e7d	e4c1d189-bdec-4b1d-9af3-8357b2584eba
b168b3cb-5283-4b39-b73a-430707b297ca	fa5b6b8e-a91e-4422-9564-99e9c967d785
0966e1a5-4d98-496b-98af-dc6700410ee8	8e2c3217-79b5-47fc-a69e-45f6c8601010
468d15e2-f793-4bbe-af49-1982bfdff43f	21f1bbe8-6a30-4052-a611-cb61562e22d5
e53032e0-bf49-4045-ad88-32e8f799d849	23664230-7fc5-484b-8f38-79835e90b3fd
e53032e0-bf49-4045-ad88-32e8f799d849	e139abbb-fd9a-473a-906d-b3a2d0dc71e9
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority, version) FROM stdin;
02d01566-038f-4921-84f1-3a4bf65155dd	\N	password	f878a587-cd36-4873-807d-9fb8b872162e	1753411736429	My password	{"value":"gblUYuZh5RluXwBFZerfcHTFiD7nHn/Rq63A1SSvH+c=","salt":"UVAnUckuc8/QaQ6G36UUwg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10	0
37b6a98e-577d-4712-b3d8-ea398a964d01	\N	password	a5685cc2-600f-45be-93df-b45ffce1ebe9	1753326221028	\N	{"value":"Jl1664WfyJJm/7Jt0gzG561mjNCC8/55IfjP6fSMu4c=","salt":"sMguVsGb7Tv83xiJAn5PlA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
4ccedd91-a494-4348-acd5-ce9c6e0c5d38	\N	password	5cdbcac7-1bed-41f7-b046-3913df4d6a1b	1753339956028	\N	{"value":"Ktks+HclDqdQCx3ensgxsmd6shCnXp8v5cFIkoa58CY=","salt":"+P5+/4QAFPzsrYwNMKp6JA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
a66ce799-e3bd-450e-b2d5-460e8f77c76f	\N	password	6b635e52-d091-4ca6-a871-d590f9fa5013	1753351518677	\N	{"value":"NzwDyH4qWS9NWu+Omkn4yeuFKaW4qeUmgX6I/l5Enjk=","salt":"QtaE8iidm8fW3flGTaZvxA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10	1
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-07-24 03:03:00.778772	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	3326175509
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-07-24 03:03:00.912408	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.23.2	\N	\N	3326175509
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-07-24 03:03:01.035574	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.23.2	\N	\N	3326175509
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-07-24 03:03:01.060807	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	3326175509
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-07-24 03:03:01.394929	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	3326175509
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-07-24 03:03:01.659008	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.23.2	\N	\N	3326175509
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-07-24 03:03:02.283757	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	3326175509
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-07-24 03:03:02.383663	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.23.2	\N	\N	3326175509
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-07-24 03:03:02.406031	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.23.2	\N	\N	3326175509
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-07-24 03:03:02.698777	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.23.2	\N	\N	3326175509
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-07-24 03:03:03.126721	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	3326175509
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-07-24 03:03:03.1513	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	3326175509
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-07-24 03:03:03.205392	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.23.2	\N	\N	3326175509
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-24 03:03:03.337936	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.23.2	\N	\N	3326175509
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-24 03:03:03.353293	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	3326175509
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-24 03:03:03.386277	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.23.2	\N	\N	3326175509
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-07-24 03:03:03.410251	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.23.2	\N	\N	3326175509
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-07-24 03:03:03.561679	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.23.2	\N	\N	3326175509
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-07-24 03:03:03.832975	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	3326175509
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-07-24 03:03:03.880443	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	3326175509
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-07-28 02:02:57.496679	119	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.25.1	\N	\N	3668176364
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-07-24 03:03:03.93308	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.23.2	\N	\N	3326175509
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-07-24 03:03:03.955123	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.23.2	\N	\N	3326175509
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-07-24 03:03:04.121131	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.23.2	\N	\N	3326175509
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-07-24 03:03:04.140859	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	3326175509
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-07-24 03:03:04.144639	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.23.2	\N	\N	3326175509
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-07-24 03:03:04.229616	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.23.2	\N	\N	3326175509
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-07-24 03:03:04.563587	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.23.2	\N	\N	3326175509
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-07-24 03:03:04.588701	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	3326175509
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-07-24 03:03:04.795117	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.23.2	\N	\N	3326175509
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-07-24 03:03:04.82805	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.23.2	\N	\N	3326175509
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-07-24 03:03:04.959737	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.23.2	\N	\N	3326175509
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-07-24 03:03:05.017548	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.23.2	\N	\N	3326175509
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-24 03:03:05.07218	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	3326175509
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-24 03:03:05.087011	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	3326175509
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-24 03:03:05.263618	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.23.2	\N	\N	3326175509
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-07-24 03:03:05.275677	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.23.2	\N	\N	3326175509
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-07-24 03:03:05.287037	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	3326175509
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-07-24 03:03:05.290702	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.23.2	\N	\N	3326175509
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-07-24 03:03:05.29446	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.23.2	\N	\N	3326175509
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-24 03:03:05.295852	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	3326175509
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-24 03:03:05.298419	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.23.2	\N	\N	3326175509
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-07-24 03:03:05.306473	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.23.2	\N	\N	3326175509
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-07-24 03:03:05.529108	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.23.2	\N	\N	3326175509
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-07-24 03:03:05.548233	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.23.2	\N	\N	3326175509
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-24 03:03:05.556196	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	3326175509
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-24 03:03:05.566505	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.23.2	\N	\N	3326175509
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-24 03:03:05.572084	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.23.2	\N	\N	3326175509
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-24 03:03:05.656107	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.23.2	\N	\N	3326175509
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-07-24 03:03:05.666136	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.23.2	\N	\N	3326175509
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-07-24 03:03:05.750076	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.23.2	\N	\N	3326175509
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-07-24 03:03:05.799133	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.23.2	\N	\N	3326175509
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-07-24 03:03:05.80623	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-07-24 03:03:05.809866	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.23.2	\N	\N	3326175509
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-07-24 03:03:05.814451	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.23.2	\N	\N	3326175509
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-24 03:03:05.829573	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.23.2	\N	\N	3326175509
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-24 03:03:05.838983	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.23.2	\N	\N	3326175509
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-24 03:03:05.886684	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.23.2	\N	\N	3326175509
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-07-24 03:03:06.076343	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.23.2	\N	\N	3326175509
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-07-24 03:03:06.151743	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.23.2	\N	\N	3326175509
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-07-24 03:03:06.161139	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.23.2	\N	\N	3326175509
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-07-24 03:03:06.177308	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.23.2	\N	\N	3326175509
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-07-24 03:03:06.184844	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.23.2	\N	\N	3326175509
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-07-24 03:03:06.195148	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	3326175509
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-07-24 03:03:06.201865	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.23.2	\N	\N	3326175509
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-07-24 03:03:06.222369	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.23.2	\N	\N	3326175509
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-07-24 03:03:06.250413	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.23.2	\N	\N	3326175509
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-07-24 03:03:06.262432	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.23.2	\N	\N	3326175509
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-07-24 03:03:06.269704	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.23.2	\N	\N	3326175509
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-07-24 03:03:06.295291	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.23.2	\N	\N	3326175509
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-07-24 03:03:06.311048	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.23.2	\N	\N	3326175509
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-07-24 03:03:06.317774	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	3326175509
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-24 03:03:06.33843	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	3326175509
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-24 03:03:06.351791	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	3326175509
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-24 03:03:06.355906	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.23.2	\N	\N	3326175509
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-24 03:03:06.510561	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.23.2	\N	\N	3326175509
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-07-24 03:03:06.570163	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.23.2	\N	\N	3326175509
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-24 03:03:06.578583	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.23.2	\N	\N	3326175509
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-24 03:03:06.588479	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.23.2	\N	\N	3326175509
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-24 03:03:06.745886	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.23.2	\N	\N	3326175509
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-07-24 03:03:06.784854	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.23.2	\N	\N	3326175509
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-24 03:03:06.832938	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.23.2	\N	\N	3326175509
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-24 03:03:06.835485	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	3326175509
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-24 03:03:06.853244	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	3326175509
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-24 03:03:06.855714	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.23.2	\N	\N	3326175509
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-07-24 03:03:06.873	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	3326175509
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-07-24 03:03:06.888208	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.23.2	\N	\N	3326175509
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-07-24 03:03:06.913695	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.23.2	\N	\N	3326175509
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-07-24 03:03:06.932076	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.23.2	\N	\N	3326175509
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.013398	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.23.2	\N	\N	3326175509
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.054811	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.23.2	\N	\N	3326175509
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.072596	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	3326175509
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.082432	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.23.2	\N	\N	3326175509
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.085229	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	3326175509
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.096421	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.23.2	\N	\N	3326175509
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.100923	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.23.2	\N	\N	3326175509
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-07-24 03:03:07.111992	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.23.2	\N	\N	3326175509
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.128259	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.23.2	\N	\N	3326175509
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.133118	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.187998	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.219536	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.223322	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.22919	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.23.2	\N	\N	3326175509
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-07-24 03:03:07.234083	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.23.2	\N	\N	3326175509
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-07-24 03:03:07.253355	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.23.2	\N	\N	3326175509
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-07-24 03:03:07.27071	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.23.2	\N	\N	3326175509
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-07-24 03:03:07.279571	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.23.2	\N	\N	3326175509
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-07-24 03:03:07.291431	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.23.2	\N	\N	3326175509
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-24 03:03:07.362152	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	3326175509
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-24 03:03:07.377558	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.23.2	\N	\N	3326175509
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-07-24 03:03:07.395924	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.23.2	\N	\N	3326175509
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-07-24 03:03:07.39883	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.23.2	\N	\N	3326175509
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-07-24 03:03:07.573601	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.23.2	\N	\N	3326175509
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-07-24 03:03:07.696142	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.23.2	\N	\N	3326175509
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-07-24 03:03:07.843243	114	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	3326175509
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-07-24 03:03:07.87513	115	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	3326175509
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-07-24 03:03:07.927813	116	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.23.2	\N	\N	3326175509
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-07-24 03:03:07.949336	117	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.23.2	\N	\N	3326175509
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-07-28 02:02:57.35868	118	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.25.1	\N	\N	3668176364
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-07-28 02:02:57.580466	120	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3668176364
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-07-28 02:02:57.664173	121	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3668176364
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-07-28 02:02:57.759569	122	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.25.1	\N	\N	3668176364
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-07-28 02:02:57.774216	123	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3668176364
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-07-28 02:02:57.845276	124	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.25.1	\N	\N	3668176364
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-07-30 02:47:29.084934	125	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:29.129508	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:30.125162	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:30.653942	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:31.004801	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:31.273007	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:31.625706	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:31.636592	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:31.963938	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	3843647977
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:32.240097	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	3843647977
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:32.605169	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	3843647977
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:32.615757	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	3843647977
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-07-30 02:47:33.22828	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	3843647977
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.415578	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	3843647977
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.47665	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	3843647977
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.606749	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	3843647977
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.628272	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	3843647977
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.657813	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	3843647977
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:33.850315	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	3843647977
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:34.403306	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	3843647977
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:34.875706	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	3843647977
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:34.984643	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	3843647977
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-07-30 02:47:35.084872	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	3843647977
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-07-30 02:47:35.776489	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	3843647977
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-07-30 02:47:35.982797	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	3843647977
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-07-30 02:47:36.080901	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	3843647977
26.2.0-36750	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-07-30 02:47:36.315158	151	EXECUTED	9:b49ce951c22f7eb16480ff085640a33a	createTable tableName=SERVER_CONFIG		\N	4.29.1	\N	\N	3843647977
26.2.0-26106	keycloak	META-INF/jpa-changelog-26.2.0.xml	2025-07-30 02:47:36.394486	152	EXECUTED	9:b5877d5dab7d10ff3a9d209d7beb6680	addColumn tableName=CREDENTIAL		\N	4.29.1	\N	\N	3843647977
26.2.6-39866-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-07-30 02:47:36.513635	153	EXECUTED	9:1dc67ccee24f30331db2cba4f372e40e	customChange		\N	4.29.1	\N	\N	3843647977
26.2.6-39866-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-07-30 02:47:36.562401	154	EXECUTED	9:b70b76f47210cf0a5f4ef0e219eac7cd	addUniqueConstraint constraintName=UK_MIGRATION_VERSION, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	3843647977
26.2.6-40088-duplicate	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-07-30 02:47:36.634184	155	EXECUTED	9:cc7e02ed69ab31979afb1982f9670e8f	customChange		\N	4.29.1	\N	\N	3843647977
26.2.6-40088-uk	keycloak	META-INF/jpa-changelog-26.2.6.xml	2025-07-30 02:47:36.753254	156	EXECUTED	9:5bb848128da7bc4595cc507383325241	addUniqueConstraint constraintName=UK_MIGRATION_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	3843647977
26.3.0-groups-description	keycloak	META-INF/jpa-changelog-26.3.0.xml	2025-07-30 02:47:36.800834	157	EXECUTED	9:e1a3c05574326fb5b246b73b9a4c4d49	addColumn tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	3843647977
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
e4ec3424-6c77-4ffb-856a-e7222a16b801	ebe2880d-ffbb-4717-9e76-6b5c076c23e8	f
e4ec3424-6c77-4ffb-856a-e7222a16b801	286f12e9-8ab3-4afb-876a-bf6f1e53d0f7	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	b0789abb-cf11-4d4a-a685-7bd2226a69b7	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	ab54a371-fdd4-4900-b970-ee2a74aad39e	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	6cdb4fb0-31fa-46c7-b727-95b1c6843f15	f
e4ec3424-6c77-4ffb-856a-e7222a16b801	9f5dcbde-2b85-4566-998f-89d6461871a2	f
e4ec3424-6c77-4ffb-856a-e7222a16b801	7933f688-d07c-4524-939c-747e2b44228d	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	4855eb4c-982e-4de2-ac9c-08e01114e584	f
e4ec3424-6c77-4ffb-856a-e7222a16b801	6e7fa33b-8456-4f6e-9afa-b339c9244171	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4115fb85-0280-42cd-8e22-fb4e86e5291b	f
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	620340cc-1e9f-4561-b4ea-548c70715778	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	9fa56c92-75a0-459a-8a5c-29563cf591c1	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	a77526c3-b8ab-4d7a-8473-d1316a9936f0	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	6043ed37-6a12-4bd5-b874-1dea2a5a8341	f
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f577d598-5619-40a1-85e1-e3a8df38e6e2	f
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	7b9fe2b6-4180-4488-9dad-fa1a79240200	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	9899cb8b-b270-4603-b0e3-369932bb060c	f
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919	t
e4ec3424-6c77-4ffb-856a-e7222a16b801	e269a132-63bf-4094-aeb3-f1b1bbf197c3	t
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	9c8c6084-99d4-414d-b275-be778249a8fa	t
e5342017-007b-4615-8c72-27d89b5f59ae	22b0b130-077d-4b7d-8917-09ecf753e097	f
e5342017-007b-4615-8c72-27d89b5f59ae	a1bf4f05-18a4-4975-bc85-367f0120a192	t
e5342017-007b-4615-8c72-27d89b5f59ae	153f5992-1222-4564-81fe-f6336a9b8889	t
e5342017-007b-4615-8c72-27d89b5f59ae	ae085333-9427-40f5-844d-328704f278a3	t
e5342017-007b-4615-8c72-27d89b5f59ae	29e39219-f881-48fa-9d38-61e9ea6b2494	t
e5342017-007b-4615-8c72-27d89b5f59ae	53492f80-4f4f-419b-aeb4-e96aed6b1a89	f
e5342017-007b-4615-8c72-27d89b5f59ae	cc2995a7-f147-428b-8071-48ddf8839047	f
e5342017-007b-4615-8c72-27d89b5f59ae	0386af28-96d9-46a7-848d-1e840c6ed2e0	t
e5342017-007b-4615-8c72-27d89b5f59ae	dcccf510-6455-4bc6-a5c2-dec8a0df06ee	t
e5342017-007b-4615-8c72-27d89b5f59ae	9861a837-90dc-46db-a146-1b36ad389991	f
e5342017-007b-4615-8c72-27d89b5f59ae	a1ecb6aa-2575-4f1b-bc18-04e4c745692a	t
e5342017-007b-4615-8c72-27d89b5f59ae	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a	t
e5342017-007b-4615-8c72-27d89b5f59ae	674aae81-737f-4e4c-9211-6b29cb97c40a	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
b85efb24-b77a-4015-9270-4aa60ec3f7ce	t	oidc	oidc	f	f	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	f	c87ac2cf-cffe-45e2-93a2-971746fe3c8d	\N		f	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo/protocol/openid-connect/userinfo	userInfoUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	true	validateSignature
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo/protocol/openid-connect/token	tokenUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	spring-boot-client	clientId
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo/protocol/openid-connect/certs	jwksUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo	issuer
b85efb24-b77a-4015-9270-4aa60ec3f7ce	true	useJwksUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	false	pkceEnabled
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo/protocol/openid-connect/auth	authorizationUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	client_secret_basic	clientAuthMethod
b85efb24-b77a-4015-9270-4aa60ec3f7ce	http://localhost:8080/realms/keycloak-demo/protocol/openid-connect/logout	logoutUrl
b85efb24-b77a-4015-9270-4aa60ec3f7ce	UX1mzUQA9fBsBVcDyBtM0TvUkbHL2SsY	clientSecret
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type, description) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
2473be7b-b86d-4672-ab35-740f60104cdd	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	${role_default-roles}	default-roles-master	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	\N
0966e1a5-4d98-496b-98af-dc6700410ee8	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	${role_admin}	admin	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	\N
7690ddf2-5667-4829-bb55-74106a250e02	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	${role_create-realm}	create-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	\N
2f51b2a2-da2f-4722-bb6c-b54b61b28f43	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_create-client}	create-client	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
bf5d4e52-2d8a-4267-98eb-ede8ebcf932f	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-realm}	view-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
ca71f1bf-b276-4f5c-9932-ffd44cd7478b	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-users}	view-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
b32bd4f1-6294-4bc4-91e8-d2f67b432693	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-clients}	view-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
f0600a99-2a9e-4a10-80d4-2964c9e5ee87	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-events}	view-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
100aed82-bc56-4893-9882-b985e096acce	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-identity-providers}	view-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
3ce0b936-4654-41cc-ad0c-52995b672001	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_view-authorization}	view-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
45b39549-66d2-4b90-8e3d-940a9a948051	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-realm}	manage-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
bec728b4-db23-4547-979f-151454f49ddd	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-users}	manage-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
92677f37-36fc-4d9f-bc33-f94f0c46ab43	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-clients}	manage-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
096f8b13-8f50-4e2d-95de-28b84ce05e8c	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-events}	manage-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
74ecbb88-9aaf-4c8e-a279-3e7fee481a90	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-identity-providers}	manage-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
7cfbce9c-877b-4c62-b0d3-f2f7cd17cf6a	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_manage-authorization}	manage-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
5cfcd980-986a-4322-bc32-189e320a3121	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_query-users}	query-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
1e29aa09-33a9-45f4-8b85-5390d5c9b66d	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_query-clients}	query-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
01415803-a2ad-4b9a-830f-badffd9a6145	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_query-realms}	query-realms	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
60dfb49b-34da-4773-b30d-83da5b321043	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_query-groups}	query-groups	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
3fa59c04-2edc-45c3-8900-00c29d65447e	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_view-profile}	view-profile	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
f180dae8-97ce-4577-8cb6-374b6988f96f	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_manage-account}	manage-account	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
14eb4d0e-e2d6-4fda-9cf2-10e78565df67	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_manage-account-links}	manage-account-links	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
7765419b-da9c-47b2-b324-e67d746584db	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_view-applications}	view-applications	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
c413fa3d-929a-4dd2-83c8-9ffcaa22c776	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_view-consent}	view-consent	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
0a1a1310-bb6e-4704-a5e4-613129bd1d62	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_manage-consent}	manage-consent	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
842292da-74f8-46b1-a7b4-b72eaad27e0e	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_view-groups}	view-groups	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
e4694ec2-578a-451d-aa01-411ae74f4ba7	ea386a21-7aad-4aa2-9971-309bc189d04f	t	${role_delete-account}	delete-account	e4ec3424-6c77-4ffb-856a-e7222a16b801	ea386a21-7aad-4aa2-9971-309bc189d04f	\N
d4bc9090-2767-4cfc-9018-5b35674daae6	ddad3566-58de-406b-81b8-9e3d0c170c11	t	${role_read-token}	read-token	e4ec3424-6c77-4ffb-856a-e7222a16b801	ddad3566-58de-406b-81b8-9e3d0c170c11	\N
e784c038-1247-43ca-82f3-ced02977871a	4310914d-fded-4dd2-b40a-09541da537f8	t	${role_impersonation}	impersonation	e4ec3424-6c77-4ffb-856a-e7222a16b801	4310914d-fded-4dd2-b40a-09541da537f8	\N
6f86200d-177c-4fbc-9c98-f95bbe7c5859	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	${role_offline-access}	offline_access	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	\N
dadd6e76-0159-4ddf-958d-76f89722f6dc	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	${role_uma_authorization}	uma_authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	\N	\N
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	${role_default-roles}	default-roles-keycloak-demo	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N	\N
9b092492-d20d-48f3-9da8-0971a5e273c6	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_create-client}	create-client	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
eff37a25-5ef8-4446-8934-6fbe06e9ec24	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-realm}	view-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
6f419259-a1f0-49d0-b50b-e3f963f63179	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-users}	view-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
e546fdad-2fa6-47c9-8e1f-1f92628ffc0c	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-clients}	view-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
4d372846-d1b7-4842-9dc6-feeab3434b62	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-events}	view-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
f737adf3-f98b-4a5a-86fa-faf20d29ff59	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-identity-providers}	view-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
c21991ce-1f25-4828-a235-2de2c8e8ae07	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_view-authorization}	view-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
88185748-e992-4c6e-aff5-66c41ca49a4f	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-realm}	manage-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
a966416a-55ad-47ac-bea6-fd12e960863a	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-users}	manage-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
a5f74c3f-f435-4dc7-b38b-feaa32ce7eec	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-clients}	manage-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
45785aee-f8a2-4f77-86aa-93cf14b4049d	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-events}	manage-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
1ac0a4b2-4162-429c-a899-07ad3ea77ad0	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-identity-providers}	manage-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
e25a72eb-9790-475e-824c-61dc30bb7707	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_manage-authorization}	manage-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
41544d4a-f134-4af1-bef1-6d9c3b6da9aa	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_query-users}	query-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
de1efcfa-887a-402c-86e2-5b5a9f559539	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_query-clients}	query-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
249d4db0-3e7a-482a-9cca-ea7f844fb8ba	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_query-realms}	query-realms	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
35832e74-96e6-41c0-a744-066d7c898ebf	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_query-groups}	query-groups	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
7727f20b-61ae-4e1d-a5b1-309b6fa14b7d	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_realm-admin}	realm-admin	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
16127ea9-c56f-4c07-b46e-c7594ed5f995	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_create-client}	create-client	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
798728d0-ea20-4b9b-a2b9-de03d16d2b90	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-realm}	view-realm	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
a65a03fc-4acb-4a04-8d12-425140b2ffed	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-users}	view-users	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
6dad1452-1624-4ef0-8ac7-5d39661295b1	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-clients}	view-clients	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
5622ec62-baa5-4573-af5c-d3f518d6c18c	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-events}	view-events	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
2f3f2847-dad4-4257-8974-73585a389825	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-identity-providers}	view-identity-providers	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
1ef22544-3d92-4691-9ea6-4e532190af64	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_view-authorization}	view-authorization	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
11a38bdc-8788-4999-a336-50cdee071674	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-realm}	manage-realm	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
07a420e6-ac7f-466d-8d96-48509f5116d6	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-users}	manage-users	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
9f97728d-aefe-4ca9-9059-c3644ad415a8	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-clients}	manage-clients	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
a163ed07-90e7-4a6c-9431-d6a908573d7d	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-events}	manage-events	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
f80993ac-fd6d-40c4-8444-50856c046eec	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-identity-providers}	manage-identity-providers	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
35aa2fd1-ec7e-436b-aa80-51c4d039267e	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_manage-authorization}	manage-authorization	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
067fabf5-6ed3-4423-bffa-57efc7377959	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_query-users}	query-users	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
53b3883d-bb50-4d93-b5f2-e0d7bf762f57	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_query-clients}	query-clients	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
dc07b3e6-5479-4e7c-bdc7-ddfa648a8d67	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_query-realms}	query-realms	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
c965f53c-cf5f-4e07-92ab-7f1faf498be2	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_query-groups}	query-groups	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
79f5f91f-6637-4eb8-88ea-da262bd17796	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_view-profile}	view-profile	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
d7582648-81b4-4fe0-8589-09c245142f21	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_manage-account}	manage-account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
0bc249da-ef33-42dc-b1b2-cafd7d342f41	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_manage-account-links}	manage-account-links	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
f3ed0f06-a843-42ee-821d-98779b81b26f	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_view-applications}	view-applications	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
a0ab7d05-a4e6-40d2-8cb6-7b960c89eb33	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_view-consent}	view-consent	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
2893cbc8-17dc-4b24-9fab-83796e11fe55	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_manage-consent}	manage-consent	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
ce251005-5242-41c2-8957-84c4224cd0e2	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_view-groups}	view-groups	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
70a90861-9357-4ad1-b00f-362611b496a6	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	t	${role_delete-account}	delete-account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	\N
bc3ccf59-175c-4e9f-973c-9c8c89af08af	300de145-01ed-4ee7-b20a-54327aa0d6e2	t	${role_impersonation}	impersonation	e4ec3424-6c77-4ffb-856a-e7222a16b801	300de145-01ed-4ee7-b20a-54327aa0d6e2	\N
be060e3a-c393-429d-aff0-c3a3e9cdf142	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	t	${role_impersonation}	impersonation	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	4bf3ccc5-075c-4bdc-a4d2-8d0963360c8d	\N
5078e601-cab3-412b-9bca-207663b6532d	3c61d0de-62ab-4385-b3da-03cf13a8bcde	t	${role_read-token}	read-token	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	3c61d0de-62ab-4385-b3da-03cf13a8bcde	\N
20ea1859-5ec2-4cf7-84c5-f8d272acb7c6	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	${role_offline-access}	offline_access	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N	\N
3ac9f814-6a94-4afb-b743-d6ad10aa222d	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	${role_uma_authorization}	uma_authorization	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	\N	\N
868d89ad-bd20-48ab-bc9c-cdba05794b15	a188eeeb-f839-4e00-8e1c-0318d2c6cd47	t		admin	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	a188eeeb-f839-4e00-8e1c-0318d2c6cd47	\N
a4dc2446-3169-4cef-8076-8414a45c12f4	a188eeeb-f839-4e00-8e1c-0318d2c6cd47	t	end user	user	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	a188eeeb-f839-4e00-8e1c-0318d2c6cd47	\N
e53032e0-bf49-4045-ad88-32e8f799d849	e5342017-007b-4615-8c72-27d89b5f59ae	f	${role_default-roles}	default-roles-test	e5342017-007b-4615-8c72-27d89b5f59ae	\N	\N
6699d2ed-6b5f-4926-b9c8-87d056ed30e5	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_create-client}	create-client	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
bbf78ce9-235a-4d46-bd65-377a97ce228e	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-realm}	view-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
2d849959-17a6-48bd-80eb-a5de3e41bd24	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-users}	view-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
f7cad76c-7c0e-4dae-b5cd-704717e1eb51	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-clients}	view-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
30091970-3a84-4f82-b383-6eb5d333840a	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-events}	view-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
548d25f9-a3b8-46c4-94a0-4624b8519c8c	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-identity-providers}	view-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
04df4071-dc94-46ae-b71a-f12f0db690c8	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_view-authorization}	view-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
9c6bced4-5ccb-4543-80f6-8ef721aaf859	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-realm}	manage-realm	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
66910cd2-625e-44c4-9135-43719cd645be	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-users}	manage-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
1b3c8bcb-8bde-464a-bd89-c19afc00da2f	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-clients}	manage-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
c5ab4dcd-7571-4711-b810-54a6deab92f4	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-events}	manage-events	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
977fc85c-e51b-4471-b3c3-dea23e3d2204	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-identity-providers}	manage-identity-providers	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
bf8f9040-4d65-49e7-a76d-dddb6d01da78	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_manage-authorization}	manage-authorization	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
4168cb51-a54d-4b14-a085-ceae3e722fb7	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_query-users}	query-users	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
866010dd-9930-43ab-827c-04babd3d4a47	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_query-clients}	query-clients	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
c7847e1f-8223-41fb-925a-1000eb98c5db	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_query-realms}	query-realms	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
06bf1cd9-ffa8-4fc5-b848-91daacd9a0ce	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_query-groups}	query-groups	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
468d15e2-f793-4bbe-af49-1982bfdff43f	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_realm-admin}	realm-admin	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
8f569230-e0a7-4a31-b264-cca1e6b03dd0	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_create-client}	create-client	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
ee90de94-3dfe-41b9-b63c-db165ccb35d4	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-realm}	view-realm	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
e25de322-c671-47f0-a954-9f72745a9157	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-users}	view-users	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
fb0fc8f8-3038-476d-ae31-c529b8990840	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-clients}	view-clients	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
a6304443-920f-4e73-a42a-dbd02b889a50	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-events}	view-events	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
b5ba2d48-25c5-44b0-ab63-3c043ab5e9e6	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-identity-providers}	view-identity-providers	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
30db83ba-bbc6-4b25-bf5b-6558a973df41	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_view-authorization}	view-authorization	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
f0053d95-6db5-4055-adbb-af31ee100a60	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-realm}	manage-realm	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
8205642c-971a-4051-943d-d12ed2565656	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-users}	manage-users	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
d614705f-210a-4a63-8e55-5a0dab18c2d9	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-clients}	manage-clients	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
3f8d83df-cae3-4af0-9fe9-b33102e04935	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-events}	manage-events	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
0f9ac804-f51f-442b-a155-826731bf13e4	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-identity-providers}	manage-identity-providers	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
62e82157-76c5-43c4-9b5d-a015a61f3667	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_manage-authorization}	manage-authorization	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
adb5a988-97a3-44b2-8301-c603cde67490	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_query-users}	query-users	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
4fe0d3df-261a-464c-b00d-d68f96cbfdef	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_query-clients}	query-clients	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
e1fd4f04-16b1-433b-85fc-4f64e7ca0a5f	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_query-realms}	query-realms	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
9bfdf199-3fbd-4b7e-989d-7d8384cf5421	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_query-groups}	query-groups	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
518525c9-d0f2-409c-a76e-68cdbbfbe868	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_view-profile}	view-profile	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
07a2b7ca-eca1-41e5-b33f-603274936e7d	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_manage-account}	manage-account	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
e4c1d189-bdec-4b1d-9af3-8357b2584eba	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_manage-account-links}	manage-account-links	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
38e120e9-ab81-4ebe-93af-922c81e388d1	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_view-applications}	view-applications	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
fa5b6b8e-a91e-4422-9564-99e9c967d785	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_view-consent}	view-consent	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
b168b3cb-5283-4b39-b73a-430707b297ca	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_manage-consent}	manage-consent	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
2d7229b4-5bac-4c35-a1e6-cd5cc70aa38d	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_view-groups}	view-groups	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
9f828c50-e111-46dc-87a1-9877a529cca9	412c16a0-f717-40d0-a0bf-1394aa071e3f	t	${role_delete-account}	delete-account	e5342017-007b-4615-8c72-27d89b5f59ae	412c16a0-f717-40d0-a0bf-1394aa071e3f	\N
8e2c3217-79b5-47fc-a69e-45f6c8601010	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	t	${role_impersonation}	impersonation	e4ec3424-6c77-4ffb-856a-e7222a16b801	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	\N
21f1bbe8-6a30-4052-a611-cb61562e22d5	40092299-0564-45c4-a3f8-ea07b2891c33	t	${role_impersonation}	impersonation	e5342017-007b-4615-8c72-27d89b5f59ae	40092299-0564-45c4-a3f8-ea07b2891c33	\N
8fc8c423-83b4-44d8-8bfc-aeddeb819472	9b7ba629-f8b4-49da-94c9-9fab7f42f014	t	${role_read-token}	read-token	e5342017-007b-4615-8c72-27d89b5f59ae	9b7ba629-f8b4-49da-94c9-9fab7f42f014	\N
23664230-7fc5-484b-8f38-79835e90b3fd	e5342017-007b-4615-8c72-27d89b5f59ae	f	${role_offline-access}	offline_access	e5342017-007b-4615-8c72-27d89b5f59ae	\N	\N
e139abbb-fd9a-473a-906d-b3a2d0dc71e9	e5342017-007b-4615-8c72-27d89b5f59ae	f	${role_uma_authorization}	uma_authorization	e5342017-007b-4615-8c72-27d89b5f59ae	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
obqj3	23.0.7	1753326194
yt3vp	24.0.4	1753668183
6ase3	26.3.0	1753843669
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
42c6e84d-a5ec-4b26-ba66-8547ea62c3d1	audience resolve	openid-connect	oidc-audience-resolve-mapper	bfc760aa-54e7-46a1-baaf-7b34707dc40b	\N
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	locale	openid-connect	oidc-usermodel-attribute-mapper	679e12fb-2ecc-49fb-a12e-27acba8c3001	\N
9d9296c7-191d-4480-b51b-e31cc514d3ba	role list	saml	saml-role-list-mapper	\N	286f12e9-8ab3-4afb-876a-bf6f1e53d0f7
dd642b00-2ea7-4763-ba01-d2b17e37c633	full name	openid-connect	oidc-full-name-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
0407234c-2b56-490e-b359-0b44e2abc061	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
20ac4647-d6cb-4d11-af33-66e67fda86ec	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
3d2b214f-f188-4b6d-a240-a0a16e753b24	username	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
a7c0eafd-88e5-499d-a8f8-f28f029134c8	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
e34858bc-4a8c-4943-8ebc-f87f986f99ba	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
d44eebd7-a14b-4518-b368-2d55f81e6ce3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
d178a3be-9115-4be6-9666-0be08b1f1c4a	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
4780df66-10c1-488b-b82e-081685c10da9	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
0eeb978f-c16b-4d18-b4a0-bee477566a8f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
bfa2481a-5753-45bc-8401-60b9279f8e1e	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	b0789abb-cf11-4d4a-a685-7bd2226a69b7
9a0c2751-8078-44f8-afbe-583239163bbd	email	openid-connect	oidc-usermodel-attribute-mapper	\N	ab54a371-fdd4-4900-b970-ee2a74aad39e
0faf3f66-cc41-4355-81b2-0ca513c03bff	email verified	openid-connect	oidc-usermodel-property-mapper	\N	ab54a371-fdd4-4900-b970-ee2a74aad39e
3504741a-0113-444f-b9b9-d4ec2a318780	address	openid-connect	oidc-address-mapper	\N	6cdb4fb0-31fa-46c7-b727-95b1c6843f15
e2a467dd-3818-4dfb-a3c4-01bce1355eda	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	9f5dcbde-2b85-4566-998f-89d6461871a2
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	9f5dcbde-2b85-4566-998f-89d6461871a2
370465c9-d49e-417e-b89e-415921355e0a	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7933f688-d07c-4524-939c-747e2b44228d
0337656e-56c9-4ed5-8294-642e0d835b54	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7933f688-d07c-4524-939c-747e2b44228d
e19e015e-516c-4fd4-8351-a2999e64c0ca	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7933f688-d07c-4524-939c-747e2b44228d
5ee299cb-f0ae-41bc-b67b-9a0ef505a292	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	fdf93804-d9e0-4cac-bb3c-33d5ee7ecbc6
25c0283c-d175-428e-9172-286f4999284c	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	4855eb4c-982e-4de2-ac9c-08e01114e584
55799e0b-efe8-4368-aad5-227c6e0ee5fe	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	4855eb4c-982e-4de2-ac9c-08e01114e584
aff2119a-d8b0-4aac-ae4b-deaf58a0bafe	acr loa level	openid-connect	oidc-acr-mapper	\N	6e7fa33b-8456-4f6e-9afa-b339c9244171
fc1b16ce-74ce-42d7-b351-b2ad655f69d3	audience resolve	openid-connect	oidc-audience-resolve-mapper	196dec86-e73c-42d2-9ac9-8b96f5ff04e0	\N
f3f7b782-7b0a-42d1-8b51-d279f1d79c21	role list	saml	saml-role-list-mapper	\N	620340cc-1e9f-4561-b4ea-548c70715778
1cd88577-f9fb-4d2b-9832-765fd195a2b7	full name	openid-connect	oidc-full-name-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
09631fc9-2e6d-4a6c-9fac-5cc160415172	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
b4f5a609-e0cc-4383-98f0-db597ad23d8f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
a78fcbb0-28d9-4fda-b983-1a5528efa947	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
9eced050-2ba4-4d89-9a61-ea44f658b025	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	username	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
027f1e09-569b-4164-a668-a03f43bdd121	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
57e3301b-c816-42da-9416-a34ec363a3bb	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
47950e6d-2e1e-45e4-8aa9-67d775728db5	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
5c5e9903-126d-45e0-9c9a-01e908871d35	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
910ff764-90c9-4735-b1bd-f48dbbd7825d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
5872ea5b-e4d3-4647-84d5-0f53f7044671	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
067db64e-4655-4d60-a011-a20a309f840b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9fa56c92-75a0-459a-8a5c-29563cf591c1
6ca5c1f4-64c7-4243-bf63-a288f8abb317	email	openid-connect	oidc-usermodel-attribute-mapper	\N	a77526c3-b8ab-4d7a-8473-d1316a9936f0
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a77526c3-b8ab-4d7a-8473-d1316a9936f0
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	address	openid-connect	oidc-address-mapper	\N	6043ed37-6a12-4bd5-b874-1dea2a5a8341
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f577d598-5619-40a1-85e1-e3a8df38e6e2
b3254154-014d-443f-bfc4-71ac2bd2a64b	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f577d598-5619-40a1-85e1-e3a8df38e6e2
7ac3a90f-8620-4b51-9075-008794f14683	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7b9fe2b6-4180-4488-9dad-fa1a79240200
a9b09484-8a48-4154-8046-1c681afe3e96	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7b9fe2b6-4180-4488-9dad-fa1a79240200
72fc1c34-9d83-4a1f-be36-321c74c8ee3a	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7b9fe2b6-4180-4488-9dad-fa1a79240200
650fa24d-a6cc-4b6d-8f9c-c53476acdd47	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4f6b15f6-12bc-4db4-a87f-6ddf68e8ee90
91c219ca-5bc9-462b-8691-65efa81dd247	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	9899cb8b-b270-4603-b0e3-369932bb060c
77bcbd1d-97a3-427b-a757-a3f22bad2c29	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9899cb8b-b270-4603-b0e3-369932bb060c
ca922d83-d665-47ac-806b-836f15d43d48	acr loa level	openid-connect	oidc-acr-mapper	\N	d5d09f1a-b58a-43b3-ad2d-c52ad7f64919
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	locale	openid-connect	oidc-usermodel-attribute-mapper	a90de389-2773-4abe-97a0-76c4097f51e1	\N
9197ddb1-e24f-489b-808c-3f819425ca2e	audience-mapper	openid-connect	oidc-audience-mapper	d2d514c2-d51d-4665-a3f7-42b3517261cd	\N
a357bd09-3e5d-4895-88cc-5588186b5219	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	e269a132-63bf-4094-aeb3-f1b1bbf197c3
5a9a7998-1843-4942-978a-f60d2776304d	sub	openid-connect	oidc-sub-mapper	\N	e269a132-63bf-4094-aeb3-f1b1bbf197c3
50cb71bb-ace4-48b0-8675-0c6971410a74	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	9c8c6084-99d4-414d-b275-be778249a8fa
7b0c6086-76a6-4634-803e-9721e1f5a12d	sub	openid-connect	oidc-sub-mapper	\N	9c8c6084-99d4-414d-b275-be778249a8fa
7fc5dae4-a95e-48b2-baa1-9947d3790467	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	015070e0-f26a-4a53-8f9b-ef3114b38cf9
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	015070e0-f26a-4a53-8f9b-ef3114b38cf9
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	015070e0-f26a-4a53-8f9b-ef3114b38cf9
536f2dc5-235b-442c-babe-cff5d670170d	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc
d94630a1-6fa8-42e9-8519-b45934e11dc9	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	afbc34ae-1d58-4e01-a1a4-d837e5e0f8bc
1a6f6d05-749f-4dd7-88af-1319a8a4227f	audience resolve	openid-connect	oidc-audience-resolve-mapper	4655a990-3381-45fa-9109-61cf86c04435	\N
e8d521e1-3040-4f1c-930c-cd24b6bef7e4	role list	saml	saml-role-list-mapper	\N	a1bf4f05-18a4-4975-bc85-367f0120a192
4b4f96e4-2832-40cc-9b99-2c76bea6a2f0	organization	saml	saml-organization-membership-mapper	\N	153f5992-1222-4564-81fe-f6336a9b8889
1fbc2c57-3dbf-418a-9e51-9bf649a948c1	full name	openid-connect	oidc-full-name-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
4a030968-942e-4b8b-b6a7-a07f22191d22	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
eac720c0-08a6-4758-a8c6-a9f636218b06	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
16ce02e5-17b2-4357-bdfb-e0574c14b471	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
cd59d420-b306-41f2-888b-b5449d8e4622	username	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
b575f474-710f-4a16-b093-de107b74c894	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
ebba8f07-e0a2-40c0-ade5-b76096b338f5	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
f8221567-f05f-462a-8ade-8e36ae5bb765	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
2e86edab-48ca-4678-8697-450ecc234367	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ae085333-9427-40f5-844d-328704f278a3
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	email	openid-connect	oidc-usermodel-attribute-mapper	\N	29e39219-f881-48fa-9d38-61e9ea6b2494
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	email verified	openid-connect	oidc-usermodel-property-mapper	\N	29e39219-f881-48fa-9d38-61e9ea6b2494
ed8ef278-14ab-4703-aae2-4126abe894f1	address	openid-connect	oidc-address-mapper	\N	53492f80-4f4f-419b-aeb4-e96aed6b1a89
7b53ea56-f7fe-47b4-93d6-c1a33716308a	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cc2995a7-f147-428b-8071-48ddf8839047
7a7d02ee-850f-49e1-b408-1d986cec7df3	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cc2995a7-f147-428b-8071-48ddf8839047
d9bc03c6-9ea0-4794-b142-a9e1d006f262	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	0386af28-96d9-46a7-848d-1e840c6ed2e0
b43e01be-6d54-4f82-9b91-d3c83856bb8a	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	0386af28-96d9-46a7-848d-1e840c6ed2e0
5d158e90-eac8-43dd-98dc-7943a30ed8c7	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	0386af28-96d9-46a7-848d-1e840c6ed2e0
25d6d334-79ac-4886-b53c-2f9e74c3bed2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	dcccf510-6455-4bc6-a5c2-dec8a0df06ee
4122d37d-1653-44be-9fd0-213c2afc1a90	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	9861a837-90dc-46db-a146-1b36ad389991
a13a260e-ebf2-4038-a843-78b8d541c3f9	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9861a837-90dc-46db-a146-1b36ad389991
b23bbe16-0ac0-4d76-9d8d-3c683b8bc015	acr loa level	openid-connect	oidc-acr-mapper	\N	a1ecb6aa-2575-4f1b-bc18-04e4c745692a
d17ccf47-2ffe-43a6-939b-549176d6a27d	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a
9ce87b3c-364a-4c25-aedf-2d8c5bef2f22	sub	openid-connect	oidc-sub-mapper	\N	4342fa4e-d33f-4b4b-b2db-0c7441bdb96a
657aeebc-246b-4281-9f4b-60ff6dd6832f	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	dc68e456-9067-4f73-93d4-16cf38272005
e045fa80-b640-4dad-b4aa-2409b187f45b	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	dc68e456-9067-4f73-93d4-16cf38272005
c24c2189-7193-4851-bb50-730542da20fd	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	dc68e456-9067-4f73-93d4-16cf38272005
25b3f52b-4b62-4963-8685-6ff36a87867f	organization	openid-connect	oidc-organization-membership-mapper	\N	674aae81-737f-4e4c-9211-6b29cb97c40a
3cb42820-6c4e-4dbb-8349-67f04373c9f1	locale	openid-connect	oidc-usermodel-attribute-mapper	d73d3479-e4f4-4d79-8cac-a96b6d1727a6	\N
61f0ca25-03b4-457a-8653-e472c4537403	aud-mapper	openid-connect	oidc-audience-mapper	a188eeeb-f839-4e00-8e1c-0318d2c6cd47	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	true	introspection.token.claim
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	true	userinfo.token.claim
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	locale	user.attribute
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	true	id.token.claim
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	true	access.token.claim
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	locale	claim.name
d5098df1-b5e4-4c72-bb66-6b2d2b90ed06	String	jsonType.label
9d9296c7-191d-4480-b51b-e31cc514d3ba	false	single
9d9296c7-191d-4480-b51b-e31cc514d3ba	Basic	attribute.nameformat
9d9296c7-191d-4480-b51b-e31cc514d3ba	Role	attribute.name
0407234c-2b56-490e-b359-0b44e2abc061	true	introspection.token.claim
0407234c-2b56-490e-b359-0b44e2abc061	true	userinfo.token.claim
0407234c-2b56-490e-b359-0b44e2abc061	lastName	user.attribute
0407234c-2b56-490e-b359-0b44e2abc061	true	id.token.claim
0407234c-2b56-490e-b359-0b44e2abc061	true	access.token.claim
0407234c-2b56-490e-b359-0b44e2abc061	family_name	claim.name
0407234c-2b56-490e-b359-0b44e2abc061	String	jsonType.label
0eeb978f-c16b-4d18-b4a0-bee477566a8f	true	introspection.token.claim
0eeb978f-c16b-4d18-b4a0-bee477566a8f	true	userinfo.token.claim
0eeb978f-c16b-4d18-b4a0-bee477566a8f	locale	user.attribute
0eeb978f-c16b-4d18-b4a0-bee477566a8f	true	id.token.claim
0eeb978f-c16b-4d18-b4a0-bee477566a8f	true	access.token.claim
0eeb978f-c16b-4d18-b4a0-bee477566a8f	locale	claim.name
0eeb978f-c16b-4d18-b4a0-bee477566a8f	String	jsonType.label
20ac4647-d6cb-4d11-af33-66e67fda86ec	true	introspection.token.claim
20ac4647-d6cb-4d11-af33-66e67fda86ec	true	userinfo.token.claim
20ac4647-d6cb-4d11-af33-66e67fda86ec	middleName	user.attribute
20ac4647-d6cb-4d11-af33-66e67fda86ec	true	id.token.claim
20ac4647-d6cb-4d11-af33-66e67fda86ec	true	access.token.claim
20ac4647-d6cb-4d11-af33-66e67fda86ec	middle_name	claim.name
20ac4647-d6cb-4d11-af33-66e67fda86ec	String	jsonType.label
3d2b214f-f188-4b6d-a240-a0a16e753b24	true	introspection.token.claim
3d2b214f-f188-4b6d-a240-a0a16e753b24	true	userinfo.token.claim
3d2b214f-f188-4b6d-a240-a0a16e753b24	username	user.attribute
3d2b214f-f188-4b6d-a240-a0a16e753b24	true	id.token.claim
3d2b214f-f188-4b6d-a240-a0a16e753b24	true	access.token.claim
3d2b214f-f188-4b6d-a240-a0a16e753b24	preferred_username	claim.name
3d2b214f-f188-4b6d-a240-a0a16e753b24	String	jsonType.label
4780df66-10c1-488b-b82e-081685c10da9	true	introspection.token.claim
4780df66-10c1-488b-b82e-081685c10da9	true	userinfo.token.claim
4780df66-10c1-488b-b82e-081685c10da9	zoneinfo	user.attribute
4780df66-10c1-488b-b82e-081685c10da9	true	id.token.claim
4780df66-10c1-488b-b82e-081685c10da9	true	access.token.claim
4780df66-10c1-488b-b82e-081685c10da9	zoneinfo	claim.name
4780df66-10c1-488b-b82e-081685c10da9	String	jsonType.label
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	true	introspection.token.claim
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	true	userinfo.token.claim
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	gender	user.attribute
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	true	id.token.claim
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	true	access.token.claim
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	gender	claim.name
6a7c00a7-d4f1-44a3-80c1-d9958e0ca008	String	jsonType.label
a7c0eafd-88e5-499d-a8f8-f28f029134c8	true	introspection.token.claim
a7c0eafd-88e5-499d-a8f8-f28f029134c8	true	userinfo.token.claim
a7c0eafd-88e5-499d-a8f8-f28f029134c8	profile	user.attribute
a7c0eafd-88e5-499d-a8f8-f28f029134c8	true	id.token.claim
a7c0eafd-88e5-499d-a8f8-f28f029134c8	true	access.token.claim
a7c0eafd-88e5-499d-a8f8-f28f029134c8	profile	claim.name
a7c0eafd-88e5-499d-a8f8-f28f029134c8	String	jsonType.label
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	true	introspection.token.claim
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	true	userinfo.token.claim
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	nickname	user.attribute
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	true	id.token.claim
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	true	access.token.claim
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	nickname	claim.name
abb2002f-ce27-4ff7-8b69-86ab2fa860d2	String	jsonType.label
bfa2481a-5753-45bc-8401-60b9279f8e1e	true	introspection.token.claim
bfa2481a-5753-45bc-8401-60b9279f8e1e	true	userinfo.token.claim
bfa2481a-5753-45bc-8401-60b9279f8e1e	updatedAt	user.attribute
bfa2481a-5753-45bc-8401-60b9279f8e1e	true	id.token.claim
bfa2481a-5753-45bc-8401-60b9279f8e1e	true	access.token.claim
bfa2481a-5753-45bc-8401-60b9279f8e1e	updated_at	claim.name
bfa2481a-5753-45bc-8401-60b9279f8e1e	long	jsonType.label
d178a3be-9115-4be6-9666-0be08b1f1c4a	true	introspection.token.claim
d178a3be-9115-4be6-9666-0be08b1f1c4a	true	userinfo.token.claim
d178a3be-9115-4be6-9666-0be08b1f1c4a	birthdate	user.attribute
d178a3be-9115-4be6-9666-0be08b1f1c4a	true	id.token.claim
d178a3be-9115-4be6-9666-0be08b1f1c4a	true	access.token.claim
d178a3be-9115-4be6-9666-0be08b1f1c4a	birthdate	claim.name
d178a3be-9115-4be6-9666-0be08b1f1c4a	String	jsonType.label
d44eebd7-a14b-4518-b368-2d55f81e6ce3	true	introspection.token.claim
d44eebd7-a14b-4518-b368-2d55f81e6ce3	true	userinfo.token.claim
d44eebd7-a14b-4518-b368-2d55f81e6ce3	website	user.attribute
d44eebd7-a14b-4518-b368-2d55f81e6ce3	true	id.token.claim
d44eebd7-a14b-4518-b368-2d55f81e6ce3	true	access.token.claim
d44eebd7-a14b-4518-b368-2d55f81e6ce3	website	claim.name
d44eebd7-a14b-4518-b368-2d55f81e6ce3	String	jsonType.label
dd642b00-2ea7-4763-ba01-d2b17e37c633	true	introspection.token.claim
dd642b00-2ea7-4763-ba01-d2b17e37c633	true	userinfo.token.claim
dd642b00-2ea7-4763-ba01-d2b17e37c633	true	id.token.claim
dd642b00-2ea7-4763-ba01-d2b17e37c633	true	access.token.claim
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	true	introspection.token.claim
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	true	userinfo.token.claim
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	firstName	user.attribute
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	true	id.token.claim
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	true	access.token.claim
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	given_name	claim.name
dfdeb4e6-c4c7-4b9f-8216-4843098b66c9	String	jsonType.label
e34858bc-4a8c-4943-8ebc-f87f986f99ba	true	introspection.token.claim
e34858bc-4a8c-4943-8ebc-f87f986f99ba	true	userinfo.token.claim
e34858bc-4a8c-4943-8ebc-f87f986f99ba	picture	user.attribute
e34858bc-4a8c-4943-8ebc-f87f986f99ba	true	id.token.claim
e34858bc-4a8c-4943-8ebc-f87f986f99ba	true	access.token.claim
e34858bc-4a8c-4943-8ebc-f87f986f99ba	picture	claim.name
e34858bc-4a8c-4943-8ebc-f87f986f99ba	String	jsonType.label
0faf3f66-cc41-4355-81b2-0ca513c03bff	true	introspection.token.claim
0faf3f66-cc41-4355-81b2-0ca513c03bff	true	userinfo.token.claim
0faf3f66-cc41-4355-81b2-0ca513c03bff	emailVerified	user.attribute
0faf3f66-cc41-4355-81b2-0ca513c03bff	true	id.token.claim
0faf3f66-cc41-4355-81b2-0ca513c03bff	true	access.token.claim
0faf3f66-cc41-4355-81b2-0ca513c03bff	email_verified	claim.name
0faf3f66-cc41-4355-81b2-0ca513c03bff	boolean	jsonType.label
9a0c2751-8078-44f8-afbe-583239163bbd	true	introspection.token.claim
9a0c2751-8078-44f8-afbe-583239163bbd	true	userinfo.token.claim
9a0c2751-8078-44f8-afbe-583239163bbd	email	user.attribute
9a0c2751-8078-44f8-afbe-583239163bbd	true	id.token.claim
9a0c2751-8078-44f8-afbe-583239163bbd	true	access.token.claim
9a0c2751-8078-44f8-afbe-583239163bbd	email	claim.name
9a0c2751-8078-44f8-afbe-583239163bbd	String	jsonType.label
3504741a-0113-444f-b9b9-d4ec2a318780	formatted	user.attribute.formatted
3504741a-0113-444f-b9b9-d4ec2a318780	country	user.attribute.country
3504741a-0113-444f-b9b9-d4ec2a318780	true	introspection.token.claim
3504741a-0113-444f-b9b9-d4ec2a318780	postal_code	user.attribute.postal_code
3504741a-0113-444f-b9b9-d4ec2a318780	true	userinfo.token.claim
3504741a-0113-444f-b9b9-d4ec2a318780	street	user.attribute.street
3504741a-0113-444f-b9b9-d4ec2a318780	true	id.token.claim
3504741a-0113-444f-b9b9-d4ec2a318780	region	user.attribute.region
3504741a-0113-444f-b9b9-d4ec2a318780	true	access.token.claim
3504741a-0113-444f-b9b9-d4ec2a318780	locality	user.attribute.locality
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	true	introspection.token.claim
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	true	userinfo.token.claim
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	phoneNumberVerified	user.attribute
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	true	id.token.claim
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	true	access.token.claim
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	phone_number_verified	claim.name
8c80eff1-b5db-4358-bf8e-042ad6d32cf7	boolean	jsonType.label
e2a467dd-3818-4dfb-a3c4-01bce1355eda	true	introspection.token.claim
e2a467dd-3818-4dfb-a3c4-01bce1355eda	true	userinfo.token.claim
e2a467dd-3818-4dfb-a3c4-01bce1355eda	phoneNumber	user.attribute
e2a467dd-3818-4dfb-a3c4-01bce1355eda	true	id.token.claim
e2a467dd-3818-4dfb-a3c4-01bce1355eda	true	access.token.claim
e2a467dd-3818-4dfb-a3c4-01bce1355eda	phone_number	claim.name
e2a467dd-3818-4dfb-a3c4-01bce1355eda	String	jsonType.label
0337656e-56c9-4ed5-8294-642e0d835b54	true	introspection.token.claim
0337656e-56c9-4ed5-8294-642e0d835b54	true	multivalued
0337656e-56c9-4ed5-8294-642e0d835b54	foo	user.attribute
0337656e-56c9-4ed5-8294-642e0d835b54	true	access.token.claim
0337656e-56c9-4ed5-8294-642e0d835b54	resource_access.${client_id}.roles	claim.name
0337656e-56c9-4ed5-8294-642e0d835b54	String	jsonType.label
370465c9-d49e-417e-b89e-415921355e0a	true	introspection.token.claim
370465c9-d49e-417e-b89e-415921355e0a	true	multivalued
370465c9-d49e-417e-b89e-415921355e0a	foo	user.attribute
370465c9-d49e-417e-b89e-415921355e0a	true	access.token.claim
370465c9-d49e-417e-b89e-415921355e0a	realm_access.roles	claim.name
370465c9-d49e-417e-b89e-415921355e0a	String	jsonType.label
e19e015e-516c-4fd4-8351-a2999e64c0ca	true	introspection.token.claim
e19e015e-516c-4fd4-8351-a2999e64c0ca	true	access.token.claim
5ee299cb-f0ae-41bc-b67b-9a0ef505a292	true	introspection.token.claim
5ee299cb-f0ae-41bc-b67b-9a0ef505a292	true	access.token.claim
25c0283c-d175-428e-9172-286f4999284c	true	introspection.token.claim
25c0283c-d175-428e-9172-286f4999284c	true	userinfo.token.claim
25c0283c-d175-428e-9172-286f4999284c	username	user.attribute
25c0283c-d175-428e-9172-286f4999284c	true	id.token.claim
25c0283c-d175-428e-9172-286f4999284c	true	access.token.claim
25c0283c-d175-428e-9172-286f4999284c	upn	claim.name
25c0283c-d175-428e-9172-286f4999284c	String	jsonType.label
55799e0b-efe8-4368-aad5-227c6e0ee5fe	true	introspection.token.claim
55799e0b-efe8-4368-aad5-227c6e0ee5fe	true	multivalued
55799e0b-efe8-4368-aad5-227c6e0ee5fe	foo	user.attribute
55799e0b-efe8-4368-aad5-227c6e0ee5fe	true	id.token.claim
55799e0b-efe8-4368-aad5-227c6e0ee5fe	true	access.token.claim
55799e0b-efe8-4368-aad5-227c6e0ee5fe	groups	claim.name
55799e0b-efe8-4368-aad5-227c6e0ee5fe	String	jsonType.label
aff2119a-d8b0-4aac-ae4b-deaf58a0bafe	true	introspection.token.claim
aff2119a-d8b0-4aac-ae4b-deaf58a0bafe	true	id.token.claim
aff2119a-d8b0-4aac-ae4b-deaf58a0bafe	true	access.token.claim
f3f7b782-7b0a-42d1-8b51-d279f1d79c21	false	single
f3f7b782-7b0a-42d1-8b51-d279f1d79c21	Basic	attribute.nameformat
f3f7b782-7b0a-42d1-8b51-d279f1d79c21	Role	attribute.name
027f1e09-569b-4164-a668-a03f43bdd121	true	introspection.token.claim
027f1e09-569b-4164-a668-a03f43bdd121	true	userinfo.token.claim
027f1e09-569b-4164-a668-a03f43bdd121	profile	user.attribute
027f1e09-569b-4164-a668-a03f43bdd121	true	id.token.claim
027f1e09-569b-4164-a668-a03f43bdd121	true	access.token.claim
027f1e09-569b-4164-a668-a03f43bdd121	profile	claim.name
027f1e09-569b-4164-a668-a03f43bdd121	String	jsonType.label
067db64e-4655-4d60-a011-a20a309f840b	true	introspection.token.claim
067db64e-4655-4d60-a011-a20a309f840b	true	userinfo.token.claim
067db64e-4655-4d60-a011-a20a309f840b	updatedAt	user.attribute
067db64e-4655-4d60-a011-a20a309f840b	true	id.token.claim
067db64e-4655-4d60-a011-a20a309f840b	true	access.token.claim
067db64e-4655-4d60-a011-a20a309f840b	updated_at	claim.name
067db64e-4655-4d60-a011-a20a309f840b	long	jsonType.label
09631fc9-2e6d-4a6c-9fac-5cc160415172	true	introspection.token.claim
09631fc9-2e6d-4a6c-9fac-5cc160415172	true	userinfo.token.claim
09631fc9-2e6d-4a6c-9fac-5cc160415172	lastName	user.attribute
09631fc9-2e6d-4a6c-9fac-5cc160415172	true	id.token.claim
09631fc9-2e6d-4a6c-9fac-5cc160415172	true	access.token.claim
09631fc9-2e6d-4a6c-9fac-5cc160415172	family_name	claim.name
09631fc9-2e6d-4a6c-9fac-5cc160415172	String	jsonType.label
1cd88577-f9fb-4d2b-9832-765fd195a2b7	true	introspection.token.claim
1cd88577-f9fb-4d2b-9832-765fd195a2b7	true	userinfo.token.claim
1cd88577-f9fb-4d2b-9832-765fd195a2b7	true	id.token.claim
1cd88577-f9fb-4d2b-9832-765fd195a2b7	true	access.token.claim
47950e6d-2e1e-45e4-8aa9-67d775728db5	true	introspection.token.claim
47950e6d-2e1e-45e4-8aa9-67d775728db5	true	userinfo.token.claim
47950e6d-2e1e-45e4-8aa9-67d775728db5	website	user.attribute
47950e6d-2e1e-45e4-8aa9-67d775728db5	true	id.token.claim
47950e6d-2e1e-45e4-8aa9-67d775728db5	true	access.token.claim
47950e6d-2e1e-45e4-8aa9-67d775728db5	website	claim.name
47950e6d-2e1e-45e4-8aa9-67d775728db5	String	jsonType.label
57e3301b-c816-42da-9416-a34ec363a3bb	true	introspection.token.claim
57e3301b-c816-42da-9416-a34ec363a3bb	true	userinfo.token.claim
57e3301b-c816-42da-9416-a34ec363a3bb	picture	user.attribute
57e3301b-c816-42da-9416-a34ec363a3bb	true	id.token.claim
57e3301b-c816-42da-9416-a34ec363a3bb	true	access.token.claim
57e3301b-c816-42da-9416-a34ec363a3bb	picture	claim.name
57e3301b-c816-42da-9416-a34ec363a3bb	String	jsonType.label
5872ea5b-e4d3-4647-84d5-0f53f7044671	true	introspection.token.claim
5872ea5b-e4d3-4647-84d5-0f53f7044671	true	userinfo.token.claim
5872ea5b-e4d3-4647-84d5-0f53f7044671	locale	user.attribute
5872ea5b-e4d3-4647-84d5-0f53f7044671	true	id.token.claim
5872ea5b-e4d3-4647-84d5-0f53f7044671	true	access.token.claim
5872ea5b-e4d3-4647-84d5-0f53f7044671	locale	claim.name
5872ea5b-e4d3-4647-84d5-0f53f7044671	String	jsonType.label
5c5e9903-126d-45e0-9c9a-01e908871d35	true	introspection.token.claim
5c5e9903-126d-45e0-9c9a-01e908871d35	true	userinfo.token.claim
5c5e9903-126d-45e0-9c9a-01e908871d35	gender	user.attribute
5c5e9903-126d-45e0-9c9a-01e908871d35	true	id.token.claim
5c5e9903-126d-45e0-9c9a-01e908871d35	true	access.token.claim
5c5e9903-126d-45e0-9c9a-01e908871d35	gender	claim.name
5c5e9903-126d-45e0-9c9a-01e908871d35	String	jsonType.label
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	true	introspection.token.claim
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	true	userinfo.token.claim
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	birthdate	user.attribute
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	true	id.token.claim
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	true	access.token.claim
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	birthdate	claim.name
818fb5c8-d3b2-4ff6-bc91-7dde0c5a0686	String	jsonType.label
910ff764-90c9-4735-b1bd-f48dbbd7825d	true	introspection.token.claim
910ff764-90c9-4735-b1bd-f48dbbd7825d	true	userinfo.token.claim
910ff764-90c9-4735-b1bd-f48dbbd7825d	zoneinfo	user.attribute
910ff764-90c9-4735-b1bd-f48dbbd7825d	true	id.token.claim
910ff764-90c9-4735-b1bd-f48dbbd7825d	true	access.token.claim
910ff764-90c9-4735-b1bd-f48dbbd7825d	zoneinfo	claim.name
910ff764-90c9-4735-b1bd-f48dbbd7825d	String	jsonType.label
9eced050-2ba4-4d89-9a61-ea44f658b025	true	introspection.token.claim
9eced050-2ba4-4d89-9a61-ea44f658b025	true	userinfo.token.claim
9eced050-2ba4-4d89-9a61-ea44f658b025	nickname	user.attribute
9eced050-2ba4-4d89-9a61-ea44f658b025	true	id.token.claim
9eced050-2ba4-4d89-9a61-ea44f658b025	true	access.token.claim
9eced050-2ba4-4d89-9a61-ea44f658b025	nickname	claim.name
9eced050-2ba4-4d89-9a61-ea44f658b025	String	jsonType.label
a78fcbb0-28d9-4fda-b983-1a5528efa947	true	introspection.token.claim
a78fcbb0-28d9-4fda-b983-1a5528efa947	true	userinfo.token.claim
a78fcbb0-28d9-4fda-b983-1a5528efa947	middleName	user.attribute
a78fcbb0-28d9-4fda-b983-1a5528efa947	true	id.token.claim
a78fcbb0-28d9-4fda-b983-1a5528efa947	true	access.token.claim
a78fcbb0-28d9-4fda-b983-1a5528efa947	middle_name	claim.name
a78fcbb0-28d9-4fda-b983-1a5528efa947	String	jsonType.label
b4f5a609-e0cc-4383-98f0-db597ad23d8f	true	introspection.token.claim
b4f5a609-e0cc-4383-98f0-db597ad23d8f	true	userinfo.token.claim
b4f5a609-e0cc-4383-98f0-db597ad23d8f	firstName	user.attribute
b4f5a609-e0cc-4383-98f0-db597ad23d8f	true	id.token.claim
b4f5a609-e0cc-4383-98f0-db597ad23d8f	true	access.token.claim
b4f5a609-e0cc-4383-98f0-db597ad23d8f	given_name	claim.name
b4f5a609-e0cc-4383-98f0-db597ad23d8f	String	jsonType.label
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	true	introspection.token.claim
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	true	userinfo.token.claim
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	username	user.attribute
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	true	id.token.claim
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	true	access.token.claim
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	preferred_username	claim.name
e6b7b152-e23a-4b42-9c48-70a0dc1d5955	String	jsonType.label
6ca5c1f4-64c7-4243-bf63-a288f8abb317	true	introspection.token.claim
6ca5c1f4-64c7-4243-bf63-a288f8abb317	true	userinfo.token.claim
6ca5c1f4-64c7-4243-bf63-a288f8abb317	email	user.attribute
6ca5c1f4-64c7-4243-bf63-a288f8abb317	true	id.token.claim
6ca5c1f4-64c7-4243-bf63-a288f8abb317	true	access.token.claim
6ca5c1f4-64c7-4243-bf63-a288f8abb317	email	claim.name
6ca5c1f4-64c7-4243-bf63-a288f8abb317	String	jsonType.label
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	true	introspection.token.claim
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	true	userinfo.token.claim
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	emailVerified	user.attribute
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	true	id.token.claim
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	true	access.token.claim
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	email_verified	claim.name
f84173e6-2147-4d1e-b26f-df68cbfe4ee7	boolean	jsonType.label
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	formatted	user.attribute.formatted
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	country	user.attribute.country
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	true	introspection.token.claim
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	postal_code	user.attribute.postal_code
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	true	userinfo.token.claim
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	street	user.attribute.street
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	true	id.token.claim
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	region	user.attribute.region
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	true	access.token.claim
5b98503a-2800-4e4d-98a2-0b9c0f24d8be	locality	user.attribute.locality
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	true	introspection.token.claim
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	true	userinfo.token.claim
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	phoneNumber	user.attribute
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	true	id.token.claim
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	true	access.token.claim
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	phone_number	claim.name
451afb8b-2103-48eb-8dcb-7b2f18bc9d63	String	jsonType.label
b3254154-014d-443f-bfc4-71ac2bd2a64b	true	introspection.token.claim
b3254154-014d-443f-bfc4-71ac2bd2a64b	true	userinfo.token.claim
b3254154-014d-443f-bfc4-71ac2bd2a64b	phoneNumberVerified	user.attribute
b3254154-014d-443f-bfc4-71ac2bd2a64b	true	id.token.claim
b3254154-014d-443f-bfc4-71ac2bd2a64b	true	access.token.claim
b3254154-014d-443f-bfc4-71ac2bd2a64b	phone_number_verified	claim.name
b3254154-014d-443f-bfc4-71ac2bd2a64b	boolean	jsonType.label
72fc1c34-9d83-4a1f-be36-321c74c8ee3a	true	introspection.token.claim
72fc1c34-9d83-4a1f-be36-321c74c8ee3a	true	access.token.claim
7ac3a90f-8620-4b51-9075-008794f14683	true	introspection.token.claim
7ac3a90f-8620-4b51-9075-008794f14683	true	multivalued
7ac3a90f-8620-4b51-9075-008794f14683	foo	user.attribute
7ac3a90f-8620-4b51-9075-008794f14683	true	access.token.claim
7ac3a90f-8620-4b51-9075-008794f14683	realm_access.roles	claim.name
7ac3a90f-8620-4b51-9075-008794f14683	String	jsonType.label
a9b09484-8a48-4154-8046-1c681afe3e96	true	introspection.token.claim
a9b09484-8a48-4154-8046-1c681afe3e96	true	multivalued
a9b09484-8a48-4154-8046-1c681afe3e96	foo	user.attribute
a9b09484-8a48-4154-8046-1c681afe3e96	true	access.token.claim
a9b09484-8a48-4154-8046-1c681afe3e96	resource_access.${client_id}.roles	claim.name
a9b09484-8a48-4154-8046-1c681afe3e96	String	jsonType.label
650fa24d-a6cc-4b6d-8f9c-c53476acdd47	true	introspection.token.claim
650fa24d-a6cc-4b6d-8f9c-c53476acdd47	true	access.token.claim
77bcbd1d-97a3-427b-a757-a3f22bad2c29	true	introspection.token.claim
77bcbd1d-97a3-427b-a757-a3f22bad2c29	true	multivalued
77bcbd1d-97a3-427b-a757-a3f22bad2c29	foo	user.attribute
77bcbd1d-97a3-427b-a757-a3f22bad2c29	true	id.token.claim
77bcbd1d-97a3-427b-a757-a3f22bad2c29	true	access.token.claim
77bcbd1d-97a3-427b-a757-a3f22bad2c29	groups	claim.name
77bcbd1d-97a3-427b-a757-a3f22bad2c29	String	jsonType.label
91c219ca-5bc9-462b-8691-65efa81dd247	true	introspection.token.claim
91c219ca-5bc9-462b-8691-65efa81dd247	true	userinfo.token.claim
91c219ca-5bc9-462b-8691-65efa81dd247	username	user.attribute
91c219ca-5bc9-462b-8691-65efa81dd247	true	id.token.claim
91c219ca-5bc9-462b-8691-65efa81dd247	true	access.token.claim
91c219ca-5bc9-462b-8691-65efa81dd247	upn	claim.name
91c219ca-5bc9-462b-8691-65efa81dd247	String	jsonType.label
ca922d83-d665-47ac-806b-836f15d43d48	true	introspection.token.claim
ca922d83-d665-47ac-806b-836f15d43d48	true	id.token.claim
ca922d83-d665-47ac-806b-836f15d43d48	true	access.token.claim
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	true	introspection.token.claim
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	true	userinfo.token.claim
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	locale	user.attribute
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	true	id.token.claim
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	true	access.token.claim
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	locale	claim.name
75bca2fa-03c9-4c8b-8995-631d4e0c1feb	String	jsonType.label
9197ddb1-e24f-489b-808c-3f819425ca2e	spring-boot-client	included.client.audience
9197ddb1-e24f-489b-808c-3f819425ca2e	true	id.token.claim
9197ddb1-e24f-489b-808c-3f819425ca2e	true	access.token.claim
9197ddb1-e24f-489b-808c-3f819425ca2e	true	introspection.token.claim
5a9a7998-1843-4942-978a-f60d2776304d	true	introspection.token.claim
5a9a7998-1843-4942-978a-f60d2776304d	true	access.token.claim
a357bd09-3e5d-4895-88cc-5588186b5219	AUTH_TIME	user.session.note
a357bd09-3e5d-4895-88cc-5588186b5219	true	introspection.token.claim
a357bd09-3e5d-4895-88cc-5588186b5219	true	id.token.claim
a357bd09-3e5d-4895-88cc-5588186b5219	true	access.token.claim
a357bd09-3e5d-4895-88cc-5588186b5219	auth_time	claim.name
a357bd09-3e5d-4895-88cc-5588186b5219	long	jsonType.label
50cb71bb-ace4-48b0-8675-0c6971410a74	AUTH_TIME	user.session.note
50cb71bb-ace4-48b0-8675-0c6971410a74	true	introspection.token.claim
50cb71bb-ace4-48b0-8675-0c6971410a74	true	id.token.claim
50cb71bb-ace4-48b0-8675-0c6971410a74	true	access.token.claim
50cb71bb-ace4-48b0-8675-0c6971410a74	auth_time	claim.name
50cb71bb-ace4-48b0-8675-0c6971410a74	long	jsonType.label
7b0c6086-76a6-4634-803e-9721e1f5a12d	true	introspection.token.claim
7b0c6086-76a6-4634-803e-9721e1f5a12d	true	access.token.claim
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	clientAddress	user.session.note
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	true	introspection.token.claim
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	true	id.token.claim
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	true	access.token.claim
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	clientAddress	claim.name
4aeca5c3-2ab7-4940-8497-7baf529cb9cb	String	jsonType.label
7fc5dae4-a95e-48b2-baa1-9947d3790467	client_id	user.session.note
7fc5dae4-a95e-48b2-baa1-9947d3790467	true	introspection.token.claim
7fc5dae4-a95e-48b2-baa1-9947d3790467	true	id.token.claim
7fc5dae4-a95e-48b2-baa1-9947d3790467	true	access.token.claim
7fc5dae4-a95e-48b2-baa1-9947d3790467	client_id	claim.name
7fc5dae4-a95e-48b2-baa1-9947d3790467	String	jsonType.label
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	clientHost	user.session.note
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	true	introspection.token.claim
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	true	id.token.claim
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	true	access.token.claim
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	clientHost	claim.name
c4d8fd6e-7a15-4bd7-8ce6-c27108a19999	String	jsonType.label
536f2dc5-235b-442c-babe-cff5d670170d	client_id	user.session.note
536f2dc5-235b-442c-babe-cff5d670170d	true	introspection.token.claim
536f2dc5-235b-442c-babe-cff5d670170d	true	id.token.claim
536f2dc5-235b-442c-babe-cff5d670170d	true	access.token.claim
536f2dc5-235b-442c-babe-cff5d670170d	client_id	claim.name
536f2dc5-235b-442c-babe-cff5d670170d	String	jsonType.label
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	clientAddress	user.session.note
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	true	introspection.token.claim
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	true	id.token.claim
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	true	access.token.claim
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	clientAddress	claim.name
ac470aca-6a76-435e-8ac1-fcfdc2ad655a	String	jsonType.label
d94630a1-6fa8-42e9-8519-b45934e11dc9	clientHost	user.session.note
d94630a1-6fa8-42e9-8519-b45934e11dc9	true	introspection.token.claim
d94630a1-6fa8-42e9-8519-b45934e11dc9	true	id.token.claim
d94630a1-6fa8-42e9-8519-b45934e11dc9	true	access.token.claim
d94630a1-6fa8-42e9-8519-b45934e11dc9	clientHost	claim.name
d94630a1-6fa8-42e9-8519-b45934e11dc9	String	jsonType.label
e8d521e1-3040-4f1c-930c-cd24b6bef7e4	false	single
e8d521e1-3040-4f1c-930c-cd24b6bef7e4	Basic	attribute.nameformat
e8d521e1-3040-4f1c-930c-cd24b6bef7e4	Role	attribute.name
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	true	introspection.token.claim
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	true	userinfo.token.claim
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	zoneinfo	user.attribute
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	true	id.token.claim
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	true	access.token.claim
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	zoneinfo	claim.name
0afeeca5-e5bb-4e7c-986a-3adeecd14d59	String	jsonType.label
16ce02e5-17b2-4357-bdfb-e0574c14b471	true	introspection.token.claim
16ce02e5-17b2-4357-bdfb-e0574c14b471	true	userinfo.token.claim
16ce02e5-17b2-4357-bdfb-e0574c14b471	nickname	user.attribute
16ce02e5-17b2-4357-bdfb-e0574c14b471	true	id.token.claim
16ce02e5-17b2-4357-bdfb-e0574c14b471	true	access.token.claim
16ce02e5-17b2-4357-bdfb-e0574c14b471	nickname	claim.name
16ce02e5-17b2-4357-bdfb-e0574c14b471	String	jsonType.label
1fbc2c57-3dbf-418a-9e51-9bf649a948c1	true	introspection.token.claim
1fbc2c57-3dbf-418a-9e51-9bf649a948c1	true	userinfo.token.claim
1fbc2c57-3dbf-418a-9e51-9bf649a948c1	true	id.token.claim
1fbc2c57-3dbf-418a-9e51-9bf649a948c1	true	access.token.claim
2e86edab-48ca-4678-8697-450ecc234367	true	introspection.token.claim
2e86edab-48ca-4678-8697-450ecc234367	true	userinfo.token.claim
2e86edab-48ca-4678-8697-450ecc234367	birthdate	user.attribute
2e86edab-48ca-4678-8697-450ecc234367	true	id.token.claim
2e86edab-48ca-4678-8697-450ecc234367	true	access.token.claim
2e86edab-48ca-4678-8697-450ecc234367	birthdate	claim.name
2e86edab-48ca-4678-8697-450ecc234367	String	jsonType.label
4a030968-942e-4b8b-b6a7-a07f22191d22	true	introspection.token.claim
4a030968-942e-4b8b-b6a7-a07f22191d22	true	userinfo.token.claim
4a030968-942e-4b8b-b6a7-a07f22191d22	lastName	user.attribute
4a030968-942e-4b8b-b6a7-a07f22191d22	true	id.token.claim
4a030968-942e-4b8b-b6a7-a07f22191d22	true	access.token.claim
4a030968-942e-4b8b-b6a7-a07f22191d22	family_name	claim.name
4a030968-942e-4b8b-b6a7-a07f22191d22	String	jsonType.label
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	true	introspection.token.claim
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	true	userinfo.token.claim
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	updatedAt	user.attribute
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	true	id.token.claim
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	true	access.token.claim
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	updated_at	claim.name
6eeabdc0-7da8-4562-9258-6c4fbfd1302c	long	jsonType.label
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	true	introspection.token.claim
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	true	userinfo.token.claim
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	gender	user.attribute
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	true	id.token.claim
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	true	access.token.claim
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	gender	claim.name
a3c0ad75-318d-4bd8-8545-40b499b8b3f1	String	jsonType.label
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	true	introspection.token.claim
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	true	userinfo.token.claim
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	firstName	user.attribute
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	true	id.token.claim
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	true	access.token.claim
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	given_name	claim.name
b1a5d1bd-35a2-45e1-8717-93c9cdceade2	String	jsonType.label
b575f474-710f-4a16-b093-de107b74c894	true	introspection.token.claim
b575f474-710f-4a16-b093-de107b74c894	true	userinfo.token.claim
b575f474-710f-4a16-b093-de107b74c894	profile	user.attribute
b575f474-710f-4a16-b093-de107b74c894	true	id.token.claim
b575f474-710f-4a16-b093-de107b74c894	true	access.token.claim
b575f474-710f-4a16-b093-de107b74c894	profile	claim.name
b575f474-710f-4a16-b093-de107b74c894	String	jsonType.label
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	true	introspection.token.claim
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	true	userinfo.token.claim
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	locale	user.attribute
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	true	id.token.claim
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	true	access.token.claim
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	locale	claim.name
cc6111f2-8b2d-4012-addc-a55b0bfa57a4	String	jsonType.label
cd59d420-b306-41f2-888b-b5449d8e4622	true	introspection.token.claim
cd59d420-b306-41f2-888b-b5449d8e4622	true	userinfo.token.claim
cd59d420-b306-41f2-888b-b5449d8e4622	username	user.attribute
cd59d420-b306-41f2-888b-b5449d8e4622	true	id.token.claim
cd59d420-b306-41f2-888b-b5449d8e4622	true	access.token.claim
cd59d420-b306-41f2-888b-b5449d8e4622	preferred_username	claim.name
cd59d420-b306-41f2-888b-b5449d8e4622	String	jsonType.label
eac720c0-08a6-4758-a8c6-a9f636218b06	true	introspection.token.claim
eac720c0-08a6-4758-a8c6-a9f636218b06	true	userinfo.token.claim
eac720c0-08a6-4758-a8c6-a9f636218b06	middleName	user.attribute
eac720c0-08a6-4758-a8c6-a9f636218b06	true	id.token.claim
eac720c0-08a6-4758-a8c6-a9f636218b06	true	access.token.claim
eac720c0-08a6-4758-a8c6-a9f636218b06	middle_name	claim.name
eac720c0-08a6-4758-a8c6-a9f636218b06	String	jsonType.label
ebba8f07-e0a2-40c0-ade5-b76096b338f5	true	introspection.token.claim
ebba8f07-e0a2-40c0-ade5-b76096b338f5	true	userinfo.token.claim
ebba8f07-e0a2-40c0-ade5-b76096b338f5	picture	user.attribute
ebba8f07-e0a2-40c0-ade5-b76096b338f5	true	id.token.claim
ebba8f07-e0a2-40c0-ade5-b76096b338f5	true	access.token.claim
ebba8f07-e0a2-40c0-ade5-b76096b338f5	picture	claim.name
ebba8f07-e0a2-40c0-ade5-b76096b338f5	String	jsonType.label
f8221567-f05f-462a-8ade-8e36ae5bb765	true	introspection.token.claim
f8221567-f05f-462a-8ade-8e36ae5bb765	true	userinfo.token.claim
f8221567-f05f-462a-8ade-8e36ae5bb765	website	user.attribute
f8221567-f05f-462a-8ade-8e36ae5bb765	true	id.token.claim
f8221567-f05f-462a-8ade-8e36ae5bb765	true	access.token.claim
f8221567-f05f-462a-8ade-8e36ae5bb765	website	claim.name
f8221567-f05f-462a-8ade-8e36ae5bb765	String	jsonType.label
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	true	introspection.token.claim
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	true	userinfo.token.claim
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	email	user.attribute
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	true	id.token.claim
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	true	access.token.claim
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	email	claim.name
cb0a3030-73a5-47fe-8b8d-ee3df7b5a227	String	jsonType.label
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	true	introspection.token.claim
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	true	userinfo.token.claim
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	emailVerified	user.attribute
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	true	id.token.claim
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	true	access.token.claim
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	email_verified	claim.name
d119d922-6ccd-4ac3-a0e5-cbe82e64f390	boolean	jsonType.label
ed8ef278-14ab-4703-aae2-4126abe894f1	formatted	user.attribute.formatted
ed8ef278-14ab-4703-aae2-4126abe894f1	country	user.attribute.country
ed8ef278-14ab-4703-aae2-4126abe894f1	true	introspection.token.claim
ed8ef278-14ab-4703-aae2-4126abe894f1	postal_code	user.attribute.postal_code
ed8ef278-14ab-4703-aae2-4126abe894f1	true	userinfo.token.claim
ed8ef278-14ab-4703-aae2-4126abe894f1	street	user.attribute.street
ed8ef278-14ab-4703-aae2-4126abe894f1	true	id.token.claim
ed8ef278-14ab-4703-aae2-4126abe894f1	region	user.attribute.region
ed8ef278-14ab-4703-aae2-4126abe894f1	true	access.token.claim
ed8ef278-14ab-4703-aae2-4126abe894f1	locality	user.attribute.locality
7a7d02ee-850f-49e1-b408-1d986cec7df3	true	introspection.token.claim
7a7d02ee-850f-49e1-b408-1d986cec7df3	true	userinfo.token.claim
7a7d02ee-850f-49e1-b408-1d986cec7df3	phoneNumberVerified	user.attribute
7a7d02ee-850f-49e1-b408-1d986cec7df3	true	id.token.claim
7a7d02ee-850f-49e1-b408-1d986cec7df3	true	access.token.claim
7a7d02ee-850f-49e1-b408-1d986cec7df3	phone_number_verified	claim.name
7a7d02ee-850f-49e1-b408-1d986cec7df3	boolean	jsonType.label
7b53ea56-f7fe-47b4-93d6-c1a33716308a	true	introspection.token.claim
7b53ea56-f7fe-47b4-93d6-c1a33716308a	true	userinfo.token.claim
7b53ea56-f7fe-47b4-93d6-c1a33716308a	phoneNumber	user.attribute
7b53ea56-f7fe-47b4-93d6-c1a33716308a	true	id.token.claim
7b53ea56-f7fe-47b4-93d6-c1a33716308a	true	access.token.claim
7b53ea56-f7fe-47b4-93d6-c1a33716308a	phone_number	claim.name
7b53ea56-f7fe-47b4-93d6-c1a33716308a	String	jsonType.label
5d158e90-eac8-43dd-98dc-7943a30ed8c7	true	introspection.token.claim
5d158e90-eac8-43dd-98dc-7943a30ed8c7	true	access.token.claim
b43e01be-6d54-4f82-9b91-d3c83856bb8a	true	introspection.token.claim
b43e01be-6d54-4f82-9b91-d3c83856bb8a	true	multivalued
b43e01be-6d54-4f82-9b91-d3c83856bb8a	foo	user.attribute
b43e01be-6d54-4f82-9b91-d3c83856bb8a	true	access.token.claim
b43e01be-6d54-4f82-9b91-d3c83856bb8a	resource_access.${client_id}.roles	claim.name
b43e01be-6d54-4f82-9b91-d3c83856bb8a	String	jsonType.label
d9bc03c6-9ea0-4794-b142-a9e1d006f262	true	introspection.token.claim
d9bc03c6-9ea0-4794-b142-a9e1d006f262	true	multivalued
d9bc03c6-9ea0-4794-b142-a9e1d006f262	foo	user.attribute
d9bc03c6-9ea0-4794-b142-a9e1d006f262	true	access.token.claim
d9bc03c6-9ea0-4794-b142-a9e1d006f262	realm_access.roles	claim.name
d9bc03c6-9ea0-4794-b142-a9e1d006f262	String	jsonType.label
25d6d334-79ac-4886-b53c-2f9e74c3bed2	true	introspection.token.claim
25d6d334-79ac-4886-b53c-2f9e74c3bed2	true	access.token.claim
4122d37d-1653-44be-9fd0-213c2afc1a90	true	introspection.token.claim
4122d37d-1653-44be-9fd0-213c2afc1a90	true	userinfo.token.claim
4122d37d-1653-44be-9fd0-213c2afc1a90	username	user.attribute
4122d37d-1653-44be-9fd0-213c2afc1a90	true	id.token.claim
4122d37d-1653-44be-9fd0-213c2afc1a90	true	access.token.claim
4122d37d-1653-44be-9fd0-213c2afc1a90	upn	claim.name
4122d37d-1653-44be-9fd0-213c2afc1a90	String	jsonType.label
a13a260e-ebf2-4038-a843-78b8d541c3f9	true	introspection.token.claim
a13a260e-ebf2-4038-a843-78b8d541c3f9	true	multivalued
a13a260e-ebf2-4038-a843-78b8d541c3f9	foo	user.attribute
a13a260e-ebf2-4038-a843-78b8d541c3f9	true	id.token.claim
a13a260e-ebf2-4038-a843-78b8d541c3f9	true	access.token.claim
a13a260e-ebf2-4038-a843-78b8d541c3f9	groups	claim.name
a13a260e-ebf2-4038-a843-78b8d541c3f9	String	jsonType.label
b23bbe16-0ac0-4d76-9d8d-3c683b8bc015	true	introspection.token.claim
b23bbe16-0ac0-4d76-9d8d-3c683b8bc015	true	id.token.claim
b23bbe16-0ac0-4d76-9d8d-3c683b8bc015	true	access.token.claim
9ce87b3c-364a-4c25-aedf-2d8c5bef2f22	true	introspection.token.claim
9ce87b3c-364a-4c25-aedf-2d8c5bef2f22	true	access.token.claim
d17ccf47-2ffe-43a6-939b-549176d6a27d	AUTH_TIME	user.session.note
d17ccf47-2ffe-43a6-939b-549176d6a27d	true	introspection.token.claim
d17ccf47-2ffe-43a6-939b-549176d6a27d	true	id.token.claim
d17ccf47-2ffe-43a6-939b-549176d6a27d	true	access.token.claim
d17ccf47-2ffe-43a6-939b-549176d6a27d	auth_time	claim.name
d17ccf47-2ffe-43a6-939b-549176d6a27d	long	jsonType.label
657aeebc-246b-4281-9f4b-60ff6dd6832f	client_id	user.session.note
657aeebc-246b-4281-9f4b-60ff6dd6832f	true	introspection.token.claim
657aeebc-246b-4281-9f4b-60ff6dd6832f	true	id.token.claim
657aeebc-246b-4281-9f4b-60ff6dd6832f	true	access.token.claim
657aeebc-246b-4281-9f4b-60ff6dd6832f	client_id	claim.name
657aeebc-246b-4281-9f4b-60ff6dd6832f	String	jsonType.label
c24c2189-7193-4851-bb50-730542da20fd	clientAddress	user.session.note
c24c2189-7193-4851-bb50-730542da20fd	true	introspection.token.claim
c24c2189-7193-4851-bb50-730542da20fd	true	id.token.claim
c24c2189-7193-4851-bb50-730542da20fd	true	access.token.claim
c24c2189-7193-4851-bb50-730542da20fd	clientAddress	claim.name
c24c2189-7193-4851-bb50-730542da20fd	String	jsonType.label
e045fa80-b640-4dad-b4aa-2409b187f45b	clientHost	user.session.note
e045fa80-b640-4dad-b4aa-2409b187f45b	true	introspection.token.claim
e045fa80-b640-4dad-b4aa-2409b187f45b	true	id.token.claim
e045fa80-b640-4dad-b4aa-2409b187f45b	true	access.token.claim
e045fa80-b640-4dad-b4aa-2409b187f45b	clientHost	claim.name
e045fa80-b640-4dad-b4aa-2409b187f45b	String	jsonType.label
25b3f52b-4b62-4963-8685-6ff36a87867f	true	introspection.token.claim
25b3f52b-4b62-4963-8685-6ff36a87867f	true	multivalued
25b3f52b-4b62-4963-8685-6ff36a87867f	true	id.token.claim
25b3f52b-4b62-4963-8685-6ff36a87867f	true	access.token.claim
25b3f52b-4b62-4963-8685-6ff36a87867f	organization	claim.name
25b3f52b-4b62-4963-8685-6ff36a87867f	String	jsonType.label
3cb42820-6c4e-4dbb-8349-67f04373c9f1	true	introspection.token.claim
3cb42820-6c4e-4dbb-8349-67f04373c9f1	true	userinfo.token.claim
3cb42820-6c4e-4dbb-8349-67f04373c9f1	locale	user.attribute
3cb42820-6c4e-4dbb-8349-67f04373c9f1	true	id.token.claim
3cb42820-6c4e-4dbb-8349-67f04373c9f1	true	access.token.claim
3cb42820-6c4e-4dbb-8349-67f04373c9f1	locale	claim.name
3cb42820-6c4e-4dbb-8349-67f04373c9f1	String	jsonType.label
61f0ca25-03b4-457a-8653-e472c4537403	true	id.token.claim
61f0ca25-03b4-457a-8653-e472c4537403	false	lightweight.claim
61f0ca25-03b4-457a-8653-e472c4537403	true	access.token.claim
61f0ca25-03b4-457a-8653-e472c4537403	true	introspection.token.claim
61f0ca25-03b4-457a-8653-e472c4537403	react-client	included.client.audience
61f0ca25-03b4-457a-8653-e472c4537403	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
e4ec3424-6c77-4ffb-856a-e7222a16b801	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	NONE	1800	36000	f	f	4310914d-fded-4dd2-b40a-09541da537f8	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	45b557b3-ca28-4ebc-828e-7e5d275e6d1b	5772e977-c129-43bb-9a18-890151314a47	f28c5649-8795-4e64-a915-dc90f62ba0b5	b0715148-8a8c-4842-a5ee-7f11a311a558	d1803b95-0797-4fb4-bebe-a2bc1fbff9dc	2592000	f	900	t	f	e5f5bac3-7c93-4b3d-8fa2-0da5d52e61e6	0	f	0	0	2473be7b-b86d-4672-ab35-740f60104cdd
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	60	300	900	\N	\N	\N	t	f	0	\N	keycloak-demo	0	\N	f	f	f	f	NONE	1800	36000	f	f	300de145-01ed-4ee7-b20a-54327aa0d6e2	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	6b5f775a-a9bf-4aa7-9dde-111e172ece6b	1c65da9a-5ad1-46fb-a70e-5a9ba8033176	82862847-425e-4248-a02c-25ce67832f75	cd7477c7-7e90-4fe1-9fa4-f724a58be309	b544dc7a-b766-4f57-855c-6da19573b6af	2592000	f	900	t	f	5f0ab695-459c-4808-b2f5-b4b51b4f5c9b	2	f	0	0	be8789cf-bb0c-4b95-adc2-20a9a0c8f856
e5342017-007b-4615-8c72-27d89b5f59ae	60	300	300	\N	\N	\N	t	f	0	\N	test	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	3c0a7c6d-9fc8-4c2c-8baa-b979a42c973e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	828a4a4f-dceb-41e9-9096-cbec51cc7d2d	d7e9983a-d3ba-4304-8bdc-2fa59bb19500	db41e3f6-21ac-4fd7-b067-ae6510ec575c	14639de8-37e0-4ae5-9097-2177bf376848	0040d466-af9b-490f-8fba-449c508cb254	2592000	f	900	t	f	9577a417-6b0d-4f53-92c0-f8b68d015044	0	f	0	0	e53032e0-bf49-4045-ad88-32e8f799d849
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
frontendUrl	e4ec3424-6c77-4ffb-856a-e7222a16b801	
acr.loa.map	e4ec3424-6c77-4ffb-856a-e7222a16b801	{}
firstBrokerLoginFlowId	e4ec3424-6c77-4ffb-856a-e7222a16b801	18f85422-d256-4cbb-a811-7559a03b2e1b
firstBrokerLoginFlowId	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	c87ac2cf-cffe-45e2-93a2-971746fe3c8d
realmReusableOtpCode	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
realmReusableOtpCode	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
oauth2DeviceCodeLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	600
oauth2DevicePollingInterval	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	5
displayName	e4ec3424-6c77-4ffb-856a-e7222a16b801	Keycloak
displayNameHtml	e4ec3424-6c77-4ffb-856a-e7222a16b801	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
permanentLockout	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
maxFailureWaitSeconds	e4ec3424-6c77-4ffb-856a-e7222a16b801	900
minimumQuickLoginWaitSeconds	e4ec3424-6c77-4ffb-856a-e7222a16b801	60
waitIncrementSeconds	e4ec3424-6c77-4ffb-856a-e7222a16b801	60
quickLoginCheckMilliSeconds	e4ec3424-6c77-4ffb-856a-e7222a16b801	1000
maxDeltaTimeSeconds	e4ec3424-6c77-4ffb-856a-e7222a16b801	43200
failureFactor	e4ec3424-6c77-4ffb-856a-e7222a16b801	30
actionTokenGeneratedByAdminLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	43200
actionTokenGeneratedByUserLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	300
defaultSignatureAlgorithm	e4ec3424-6c77-4ffb-856a-e7222a16b801	RS256
offlineSessionMaxLifespanEnabled	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
offlineSessionMaxLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	5184000
cibaBackchannelTokenDeliveryMode	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	poll
cibaExpiresIn	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	120
cibaInterval	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	5
cibaAuthRequestedUserHint	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	login_hint
parRequestUriLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	60
shortVerificationUri	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
actionTokenGeneratedByUserLifespan.verify-email	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
actionTokenGeneratedByUserLifespan.reset-credentials	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
actionTokenGeneratedByUserLifespan.execute-actions	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
webAuthnPolicyRpEntityName	e4ec3424-6c77-4ffb-856a-e7222a16b801	keycloak
webAuthnPolicySignatureAlgorithms	e4ec3424-6c77-4ffb-856a-e7222a16b801	ES256
clientSessionIdleTimeout	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
clientSessionMaxLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
clientOfflineSessionIdleTimeout	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
clientOfflineSessionMaxLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
frontendUrl	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
acr.loa.map	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	{}
webAuthnPolicyRpId	e4ec3424-6c77-4ffb-856a-e7222a16b801	
webAuthnPolicyAttestationConveyancePreference	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyAuthenticatorAttachment	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyRequireResidentKey	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyUserVerificationRequirement	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyCreateTimeout	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
webAuthnPolicyRpEntityNamePasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	ES256
webAuthnPolicyRpIdPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	
webAuthnPolicyAttestationConveyancePreferencePasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyRequireResidentKeyPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	not specified
webAuthnPolicyCreateTimeoutPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	false
client-policies.profiles	e4ec3424-6c77-4ffb-856a-e7222a16b801	{"profiles":[]}
client-policies.policies	e4ec3424-6c77-4ffb-856a-e7222a16b801	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	e4ec3424-6c77-4ffb-856a-e7222a16b801	
_browser_header.xContentTypeOptions	e4ec3424-6c77-4ffb-856a-e7222a16b801	nosniff
_browser_header.referrerPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	no-referrer
_browser_header.xRobotsTag	e4ec3424-6c77-4ffb-856a-e7222a16b801	none
_browser_header.xFrameOptions	e4ec3424-6c77-4ffb-856a-e7222a16b801	SAMEORIGIN
_browser_header.contentSecurityPolicy	e4ec3424-6c77-4ffb-856a-e7222a16b801	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e4ec3424-6c77-4ffb-856a-e7222a16b801	1; mode=block
_browser_header.strictTransportSecurity	e4ec3424-6c77-4ffb-856a-e7222a16b801	max-age=31536000; includeSubDomains
displayName	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
displayNameHtml	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
bruteForceProtected	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
permanentLockout	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
maxFailureWaitSeconds	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	900
minimumQuickLoginWaitSeconds	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	60
waitIncrementSeconds	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	60
quickLoginCheckMilliSeconds	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	1000
maxDeltaTimeSeconds	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	43200
failureFactor	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	30
actionTokenGeneratedByAdminLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	43200
actionTokenGeneratedByUserLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	300
defaultSignatureAlgorithm	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	RS256
cibaBackchannelTokenDeliveryMode	e4ec3424-6c77-4ffb-856a-e7222a16b801	poll
cibaExpiresIn	e4ec3424-6c77-4ffb-856a-e7222a16b801	120
cibaAuthRequestedUserHint	e4ec3424-6c77-4ffb-856a-e7222a16b801	login_hint
parRequestUriLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	60
cibaInterval	e4ec3424-6c77-4ffb-856a-e7222a16b801	5
offlineSessionMaxLifespanEnabled	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
offlineSessionMaxLifespan	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	5184000
webAuthnPolicyRpEntityName	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	keycloak
webAuthnPolicySignatureAlgorithms	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	ES256
webAuthnPolicyRpId	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
webAuthnPolicyAttestationConveyancePreference	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyAuthenticatorAttachment	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyRequireResidentKey	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyUserVerificationRequirement	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyCreateTimeout	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
webAuthnPolicyAvoidSameAuthenticatorRegister	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
webAuthnPolicyRpEntityNamePasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	keycloak
oauth2DeviceCodeLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	600
oauth2DevicePollingInterval	e4ec3424-6c77-4ffb-856a-e7222a16b801	5
webAuthnPolicySignatureAlgorithmsPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	ES256
webAuthnPolicyRpIdPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
webAuthnPolicyAttestationConveyancePreferencePasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
clientSessionIdleTimeout	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
clientSessionMaxLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
clientOfflineSessionIdleTimeout	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
clientOfflineSessionMaxLifespan	e4ec3424-6c77-4ffb-856a-e7222a16b801	0
webAuthnPolicyAuthenticatorAttachmentPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyRequireResidentKeyPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	not specified
webAuthnPolicyCreateTimeoutPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	false
client-policies.profiles	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	{"profiles":[]}
client-policies.policies	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	
_browser_header.xContentTypeOptions	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	nosniff
_browser_header.referrerPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	no-referrer
_browser_header.xRobotsTag	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	none
_browser_header.xFrameOptions	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	SAMEORIGIN
_browser_header.contentSecurityPolicy	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	1; mode=block
_browser_header.strictTransportSecurity	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	max-age=31536000; includeSubDomains
_browser_header.contentSecurityPolicyReportOnly	e5342017-007b-4615-8c72-27d89b5f59ae	
_browser_header.xContentTypeOptions	e5342017-007b-4615-8c72-27d89b5f59ae	nosniff
_browser_header.referrerPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	no-referrer
_browser_header.xRobotsTag	e5342017-007b-4615-8c72-27d89b5f59ae	none
_browser_header.xFrameOptions	e5342017-007b-4615-8c72-27d89b5f59ae	SAMEORIGIN
_browser_header.contentSecurityPolicy	e5342017-007b-4615-8c72-27d89b5f59ae	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	e5342017-007b-4615-8c72-27d89b5f59ae	max-age=31536000; includeSubDomains
bruteForceProtected	e5342017-007b-4615-8c72-27d89b5f59ae	false
permanentLockout	e5342017-007b-4615-8c72-27d89b5f59ae	false
maxTemporaryLockouts	e5342017-007b-4615-8c72-27d89b5f59ae	0
bruteForceStrategy	e5342017-007b-4615-8c72-27d89b5f59ae	MULTIPLE
maxFailureWaitSeconds	e5342017-007b-4615-8c72-27d89b5f59ae	900
minimumQuickLoginWaitSeconds	e5342017-007b-4615-8c72-27d89b5f59ae	60
waitIncrementSeconds	e5342017-007b-4615-8c72-27d89b5f59ae	60
quickLoginCheckMilliSeconds	e5342017-007b-4615-8c72-27d89b5f59ae	1000
maxDeltaTimeSeconds	e5342017-007b-4615-8c72-27d89b5f59ae	43200
failureFactor	e5342017-007b-4615-8c72-27d89b5f59ae	30
realmReusableOtpCode	e5342017-007b-4615-8c72-27d89b5f59ae	false
defaultSignatureAlgorithm	e5342017-007b-4615-8c72-27d89b5f59ae	RS256
offlineSessionMaxLifespanEnabled	e5342017-007b-4615-8c72-27d89b5f59ae	false
offlineSessionMaxLifespan	e5342017-007b-4615-8c72-27d89b5f59ae	5184000
actionTokenGeneratedByAdminLifespan	e5342017-007b-4615-8c72-27d89b5f59ae	43200
actionTokenGeneratedByUserLifespan	e5342017-007b-4615-8c72-27d89b5f59ae	300
oauth2DeviceCodeLifespan	e5342017-007b-4615-8c72-27d89b5f59ae	600
oauth2DevicePollingInterval	e5342017-007b-4615-8c72-27d89b5f59ae	5
webAuthnPolicyRpEntityName	e5342017-007b-4615-8c72-27d89b5f59ae	keycloak
webAuthnPolicySignatureAlgorithms	e5342017-007b-4615-8c72-27d89b5f59ae	ES256,RS256
webAuthnPolicyRpId	e5342017-007b-4615-8c72-27d89b5f59ae	
webAuthnPolicyAttestationConveyancePreference	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyAuthenticatorAttachment	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyRequireResidentKey	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyUserVerificationRequirement	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyCreateTimeout	e5342017-007b-4615-8c72-27d89b5f59ae	0
webAuthnPolicyAvoidSameAuthenticatorRegister	e5342017-007b-4615-8c72-27d89b5f59ae	false
webAuthnPolicyRpEntityNamePasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	ES256,RS256
webAuthnPolicyRpIdPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	
webAuthnPolicyAttestationConveyancePreferencePasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyRequireResidentKeyPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	not specified
webAuthnPolicyCreateTimeoutPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	e5342017-007b-4615-8c72-27d89b5f59ae	false
cibaBackchannelTokenDeliveryMode	e5342017-007b-4615-8c72-27d89b5f59ae	poll
cibaExpiresIn	e5342017-007b-4615-8c72-27d89b5f59ae	120
cibaInterval	e5342017-007b-4615-8c72-27d89b5f59ae	5
cibaAuthRequestedUserHint	e5342017-007b-4615-8c72-27d89b5f59ae	login_hint
parRequestUriLifespan	e5342017-007b-4615-8c72-27d89b5f59ae	60
firstBrokerLoginFlowId	e5342017-007b-4615-8c72-27d89b5f59ae	df1b8d09-988e-48d8-bd7a-710c59ffaf2e
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
e4ec3424-6c77-4ffb-856a-e7222a16b801	jboss-logging
4fd9dee5-48e8-47ac-8e29-554bec7ffeba	jboss-logging
e5342017-007b-4615-8c72-27d89b5f59ae	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	e4ec3424-6c77-4ffb-856a-e7222a16b801
password	password	t	t	4fd9dee5-48e8-47ac-8e29-554bec7ffeba
password	password	t	t	e5342017-007b-4615-8c72-27d89b5f59ae
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
ea386a21-7aad-4aa2-9971-309bc189d04f	/realms/master/account/*
bfc760aa-54e7-46a1-baaf-7b34707dc40b	/realms/master/account/*
679e12fb-2ecc-49fb-a12e-27acba8c3001	/admin/master/console/*
c3fb8f1d-aac3-41e5-a299-621bdbba4bd9	/realms/keycloak-demo/account/*
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	/realms/keycloak-demo/account/*
a90de389-2773-4abe-97a0-76c4097f51e1	/admin/keycloak-demo/console/*
d2d514c2-d51d-4665-a3f7-42b3517261cd	http://localhost:8081/*
412c16a0-f717-40d0-a0bf-1394aa071e3f	/realms/test/account/*
4655a990-3381-45fa-9109-61cf86c04435	/realms/test/account/*
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	/admin/test/console/*
eb655986-9bbe-4fee-989f-f414bce735ff	http://localhost:8082/*
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	http://localhost:3000/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
ca0b443b-7c07-40dd-9df8-c73d8fe22ddf	VERIFY_EMAIL	Verify Email	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	VERIFY_EMAIL	50
177647d4-2698-4ec8-bb98-184793badb42	UPDATE_PROFILE	Update Profile	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	UPDATE_PROFILE	40
45b8a768-e44a-410f-88ad-a379ae04fee0	CONFIGURE_TOTP	Configure OTP	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	CONFIGURE_TOTP	10
4238144f-51b3-4577-9951-22ef6d46af00	UPDATE_PASSWORD	Update Password	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	UPDATE_PASSWORD	30
035f5f3b-9911-4c29-8527-608ecc7e9aca	TERMS_AND_CONDITIONS	Terms and Conditions	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	f	TERMS_AND_CONDITIONS	20
eb0a04a6-abce-4e50-9ecb-e132af678f15	delete_account	Delete Account	e4ec3424-6c77-4ffb-856a-e7222a16b801	f	f	delete_account	60
4d3473c0-f938-4825-9b42-75da840ed475	update_user_locale	Update User Locale	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	update_user_locale	1000
559b3b99-39bc-49d1-93a6-6ba9ff6136b3	webauthn-register	Webauthn Register	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	webauthn-register	70
40d68f6e-604e-4a21-9cf8-183e160a669e	webauthn-register-passwordless	Webauthn Register Passwordless	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	webauthn-register-passwordless	80
319e29d4-c618-4148-99ac-0c8dcdde2bc5	VERIFY_EMAIL	Verify Email	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	VERIFY_EMAIL	50
d5a7387d-91ae-4671-b265-8c7d9339b2c3	UPDATE_PROFILE	Update Profile	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	UPDATE_PROFILE	40
356d6232-a349-4250-8de6-85eb0f15669c	CONFIGURE_TOTP	Configure OTP	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	CONFIGURE_TOTP	10
9cec3ea4-4686-4fd0-ac01-d09cc0f74ea2	UPDATE_PASSWORD	Update Password	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	UPDATE_PASSWORD	30
b136e6da-326d-4393-ba15-9030f80775e7	TERMS_AND_CONDITIONS	Terms and Conditions	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	f	TERMS_AND_CONDITIONS	20
7e9c24f8-33c0-4c9e-b93c-cba1825d1fdc	delete_account	Delete Account	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	f	f	delete_account	60
e0e5096b-3700-4802-a20b-ee974fd68bc4	update_user_locale	Update User Locale	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	update_user_locale	1000
332266ca-1f70-4cd7-87f4-bc1ef0b68e82	webauthn-register	Webauthn Register	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	webauthn-register	70
fd2063c7-3fa2-40b0-9be7-41f7456f71ab	webauthn-register-passwordless	Webauthn Register Passwordless	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	webauthn-register-passwordless	80
9d27793e-07ab-4320-b15d-fc004d974fe3	delete_credential	Delete Credential	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	delete_credential	100
590b8f0e-7043-4fdb-86a1-545470a97966	delete_credential	Delete Credential	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	delete_credential	100
c9c2a28e-24f4-49e6-9aa3-1a029971dffa	idp_link	Linking Identity Provider	e4ec3424-6c77-4ffb-856a-e7222a16b801	t	f	idp_link	110
7179b14a-2b68-4e77-943e-d70876f9d2a8	idp_link	Linking Identity Provider	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	t	f	idp_link	110
05446714-5e6e-4641-8877-ed37250ea55c	VERIFY_EMAIL	Verify Email	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	VERIFY_EMAIL	50
bf231540-a3af-4331-b9c6-55f68264b865	UPDATE_PROFILE	Update Profile	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	UPDATE_PROFILE	40
a2dd973a-6c05-4def-b0b9-6f2f4ea738be	CONFIGURE_TOTP	Configure OTP	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	CONFIGURE_TOTP	10
d7675738-40a2-42c8-bcbd-86d59f6872b9	UPDATE_PASSWORD	Update Password	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	UPDATE_PASSWORD	30
6ac6fdb9-79f6-4a46-aed9-277985c85a91	TERMS_AND_CONDITIONS	Terms and Conditions	e5342017-007b-4615-8c72-27d89b5f59ae	f	f	TERMS_AND_CONDITIONS	20
86f68c8a-d55a-4e38-ba26-6c6745b9d0ea	delete_account	Delete Account	e5342017-007b-4615-8c72-27d89b5f59ae	f	f	delete_account	60
c26e4b17-2fc5-4d9e-b975-945225abeed5	delete_credential	Delete Credential	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	delete_credential	100
e9a3814b-6d82-4924-b761-561a401fa4ba	update_user_locale	Update User Locale	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	update_user_locale	1000
993c7f84-1426-4aac-8bce-d97335bdeda5	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	120
acc94c35-755c-40d7-99f4-5ed5f1ad5634	webauthn-register	Webauthn Register	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	webauthn-register	70
f2558c8e-6006-472b-89cb-e6592f4091c3	webauthn-register-passwordless	Webauthn Register Passwordless	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	webauthn-register-passwordless	80
a65ca326-93dd-401b-8ba4-d58dc20cae37	VERIFY_PROFILE	Verify Profile	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	VERIFY_PROFILE	90
7597aef7-ceb0-4e71-ae59-e4b66ba563ad	idp_link	Linking Identity Provider	e5342017-007b-4615-8c72-27d89b5f59ae	t	f	idp_link	110
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
bfc760aa-54e7-46a1-baaf-7b34707dc40b	f180dae8-97ce-4577-8cb6-374b6988f96f
bfc760aa-54e7-46a1-baaf-7b34707dc40b	842292da-74f8-46b1-a7b4-b72eaad27e0e
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	ce251005-5242-41c2-8957-84c4224cd0e2
196dec86-e73c-42d2-9ac9-8b96f5ff04e0	d7582648-81b4-4fe0-8589-09c245142f21
4655a990-3381-45fa-9109-61cf86c04435	07a2b7ca-eca1-41e5-b33f-603274936e7d
4655a990-3381-45fa-9109-61cf86c04435	2d7229b4-5bac-4c35-a1e6-cd5cc70aa38d
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: server_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.server_config (server_config_key, value, version) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
a5685cc2-600f-45be-93df-b45ffce1ebe9	\N	e43b35cd-925d-4c28-b455-c86899dea9ab	f	t	\N	\N	\N	e4ec3424-6c77-4ffb-856a-e7222a16b801	admin	1753326218774	\N	0
6b635e52-d091-4ca6-a871-d590f9fa5013	brett-hinschberger@los-ij.co.jp	brett-hinschberger@los-ij.co.jp	t	t	\N	Brett	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	admin@test.com	1753330767365	\N	0
5cdbcac7-1bed-41f7-b046-3913df4d6a1b	brett7y7@gmail.com	brett7y7@gmail.com	t	t	\N	Brett	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	user@test.com	1753330908075	\N	0
f878a587-cd36-4873-807d-9fb8b872162e	a@a.com	a@a.com	t	t	\N	\N	\N	4fd9dee5-48e8-47ac-8e29-554bec7ffeba	aaa	1753411686143	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
2473be7b-b86d-4672-ab35-740f60104cdd	a5685cc2-600f-45be-93df-b45ffce1ebe9
0966e1a5-4d98-496b-98af-dc6700410ee8	a5685cc2-600f-45be-93df-b45ffce1ebe9
9b092492-d20d-48f3-9da8-0971a5e273c6	a5685cc2-600f-45be-93df-b45ffce1ebe9
eff37a25-5ef8-4446-8934-6fbe06e9ec24	a5685cc2-600f-45be-93df-b45ffce1ebe9
6f419259-a1f0-49d0-b50b-e3f963f63179	a5685cc2-600f-45be-93df-b45ffce1ebe9
e546fdad-2fa6-47c9-8e1f-1f92628ffc0c	a5685cc2-600f-45be-93df-b45ffce1ebe9
4d372846-d1b7-4842-9dc6-feeab3434b62	a5685cc2-600f-45be-93df-b45ffce1ebe9
f737adf3-f98b-4a5a-86fa-faf20d29ff59	a5685cc2-600f-45be-93df-b45ffce1ebe9
c21991ce-1f25-4828-a235-2de2c8e8ae07	a5685cc2-600f-45be-93df-b45ffce1ebe9
88185748-e992-4c6e-aff5-66c41ca49a4f	a5685cc2-600f-45be-93df-b45ffce1ebe9
a966416a-55ad-47ac-bea6-fd12e960863a	a5685cc2-600f-45be-93df-b45ffce1ebe9
a5f74c3f-f435-4dc7-b38b-feaa32ce7eec	a5685cc2-600f-45be-93df-b45ffce1ebe9
45785aee-f8a2-4f77-86aa-93cf14b4049d	a5685cc2-600f-45be-93df-b45ffce1ebe9
1ac0a4b2-4162-429c-a899-07ad3ea77ad0	a5685cc2-600f-45be-93df-b45ffce1ebe9
e25a72eb-9790-475e-824c-61dc30bb7707	a5685cc2-600f-45be-93df-b45ffce1ebe9
41544d4a-f134-4af1-bef1-6d9c3b6da9aa	a5685cc2-600f-45be-93df-b45ffce1ebe9
de1efcfa-887a-402c-86e2-5b5a9f559539	a5685cc2-600f-45be-93df-b45ffce1ebe9
249d4db0-3e7a-482a-9cca-ea7f844fb8ba	a5685cc2-600f-45be-93df-b45ffce1ebe9
35832e74-96e6-41c0-a744-066d7c898ebf	a5685cc2-600f-45be-93df-b45ffce1ebe9
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	6b635e52-d091-4ca6-a871-d590f9fa5013
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	5cdbcac7-1bed-41f7-b046-3913df4d6a1b
be8789cf-bb0c-4b95-adc2-20a9a0c8f856	f878a587-cd36-4873-807d-9fb8b872162e
868d89ad-bd20-48ab-bc9c-cdba05794b15	6b635e52-d091-4ca6-a871-d590f9fa5013
a4dc2446-3169-4cef-8076-8414a45c12f4	6b635e52-d091-4ca6-a871-d590f9fa5013
a4dc2446-3169-4cef-8076-8414a45c12f4	5cdbcac7-1bed-41f7-b046-3913df4d6a1b
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
679e12fb-2ecc-49fb-a12e-27acba8c3001	+
a90de389-2773-4abe-97a0-76c4097f51e1	+
d2d514c2-d51d-4665-a3f7-42b3517261cd	http://localhost:8081
d73d3479-e4f4-4d79-8cac-a96b6d1727a6	+
eb655986-9bbe-4fee-989f-f414bce735ff	http://localhost:8082
a188eeeb-f839-4e00-8e1c-0318d2c6cd47	http://localhost:3000
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: server_config SERVER_CONFIG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.server_config
    ADD CONSTRAINT "SERVER_CONFIG_pkey" PRIMARY KEY (server_config_key);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: migration_model uk_migration_update_time; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_update_time UNIQUE (update_time);


--
-- Name: migration_model uk_migration_version; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT uk_migration_version UNIQUE (version);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

