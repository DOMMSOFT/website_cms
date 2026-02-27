--
-- PostgreSQL database dump
--


-- Dumped from database version 15.16 (Debian 15.16-1.pgdg13+1)
-- Dumped by pg_dump version 15.16 (Debian 15.16-1.pgdg13+1)

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
-- Name: applications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.applications (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'new'::character varying,
    date_created timestamp with time zone,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(255),
    country character varying(255) NOT NULL,
    job_title character varying(255),
    job_slug character varying(255),
    motivation text,
    cv uuid
);


ALTER TABLE public.applications OWNER TO directus;

--
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.blog_posts (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying,
    sort integer,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    slug character varying(255),
    excerpt text,
    content text,
    date_published timestamp with time zone,
    author character varying(255),
    tags json,
    cover_image uuid
);


ALTER TABLE public.blog_posts OWNER TO directus;

--
-- Name: contacts; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.contacts (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'new'::character varying,
    date_created timestamp with time zone,
    name character varying(255),
    email character varying(255),
    subject character varying(255),
    message text,
    notes text
);


ALTER TABLE public.contacts OWNER TO directus;

--
-- Name: directus_access; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_access (
    id uuid NOT NULL,
    role uuid,
    "user" uuid,
    policy uuid NOT NULL,
    sort integer
);


ALTER TABLE public.directus_access OWNER TO directus;

--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent text,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(64),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255),
    versioning boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_comments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_comments (
    id uuid NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid
);


ALTER TABLE public.directus_comments OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_deployment_projects; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_deployment_projects (
    id uuid NOT NULL,
    deployment uuid NOT NULL,
    external_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_deployment_projects OWNER TO directus;

--
-- Name: directus_deployment_runs; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_deployment_runs (
    id uuid NOT NULL,
    project uuid NOT NULL,
    external_id character varying(255) NOT NULL,
    target character varying(255) NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_deployment_runs OWNER TO directus;

--
-- Name: directus_deployments; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_deployments (
    id uuid NOT NULL,
    provider character varying(255) NOT NULL,
    credentials text,
    options text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_deployments OWNER TO directus;

--
-- Name: directus_extensions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_extensions (
    enabled boolean DEFAULT true NOT NULL,
    id uuid NOT NULL,
    folder character varying(255) NOT NULL,
    source character varying(255) NOT NULL,
    bundle uuid
);


ALTER TABLE public.directus_extensions OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text,
    searchable boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    created_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json,
    focal_point_x integer,
    focal_point_y integer,
    tus_id character varying(64),
    tus_data json,
    uploaded_on timestamp with time zone
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(64),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(64) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text,
    policy uuid NOT NULL
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_policies; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_policies (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'badge'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_policies OWNER TO directus;

--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(64) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer,
    version uuid
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(64) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    parent uuid
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent text,
    share uuid,
    origin character varying(255),
    next_token character varying(64)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(255) DEFAULT '#6644FF'::character varying NOT NULL,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json,
    public_favicon uuid,
    default_appearance character varying(255) DEFAULT 'auto'::character varying NOT NULL,
    default_theme_light character varying(255),
    theme_light_overrides json,
    default_theme_dark character varying(255),
    theme_dark_overrides json,
    report_error_url character varying(255),
    report_bug_url character varying(255),
    report_feature_url character varying(255),
    public_registration boolean DEFAULT false NOT NULL,
    public_registration_verify_email boolean DEFAULT true NOT NULL,
    public_registration_role uuid,
    public_registration_email_filter json,
    visual_editor_urls json,
    project_id uuid,
    mcp_enabled boolean DEFAULT false NOT NULL,
    mcp_allow_deletes boolean DEFAULT false NOT NULL,
    mcp_prompts_collection character varying(255) DEFAULT NULL::character varying,
    mcp_system_prompt_enabled boolean DEFAULT true NOT NULL,
    mcp_system_prompt text,
    project_owner character varying(255),
    project_usage character varying(255),
    org_name character varying(255),
    product_updates boolean,
    project_status character varying(255),
    ai_openai_api_key text,
    ai_anthropic_api_key text,
    ai_system_prompt text,
    ai_google_api_key text,
    ai_openai_compatible_api_key text,
    ai_openai_compatible_base_url text,
    ai_openai_compatible_name text,
    ai_openai_compatible_models json,
    ai_openai_compatible_headers json,
    ai_openai_allowed_models json,
    ai_anthropic_allowed_models json,
    ai_google_allowed_models json,
    collaborative_editing_enabled boolean DEFAULT false NOT NULL
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true,
    appearance character varying(255),
    theme_dark character varying(255),
    theme_light character varying(255),
    theme_light_overrides json,
    theme_dark_overrides json,
    text_direction character varying(255) DEFAULT 'auto'::character varying NOT NULL
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_versions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_versions (
    id uuid NOT NULL,
    key character varying(64) NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    hash character varying(255),
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_updated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    user_updated uuid,
    delta json
);


ALTER TABLE public.directus_versions OWNER TO directus;

--
-- Name: job_offers; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.job_offers (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying,
    sort integer,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    department character varying(255) NOT NULL,
    location character varying(255),
    type character varying(255) NOT NULL,
    description text,
    content text,
    date_published timestamp with time zone
);


ALTER TABLE public.job_offers OWNER TO directus;

--
-- Name: newsletter_subscribers; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.newsletter_subscribers (
    id uuid NOT NULL,
    email character varying(255),
    date_created timestamp with time zone
);


ALTER TABLE public.newsletter_subscribers OWNER TO directus;

--
-- Name: products; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.products (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying,
    sort integer,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    name character varying(255),
    slug character varying(255),
    description text,
    content text,
    icon character varying(255),
    color character varying(255),
    features json,
    image uuid,
    featured boolean DEFAULT false,
    url character varying(255) DEFAULT NULL::character varying,
    category character varying(255) DEFAULT 'entreprise'::character varying
);


ALTER TABLE public.products OWNER TO directus;

--
-- Name: site_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.site_settings (
    id uuid NOT NULL,
    hero_title character varying(255),
    hero_subtitle character varying(255),
    hero_description text,
    hero_badge character varying(255),
    cta_primary_text character varying(255),
    cta_primary_url character varying(255),
    cta_secondary_text character varying(255),
    cta_secondary_url character varying(255),
    social_twitter character varying(255),
    social_linkedin character varying(255),
    social_github character varying(255),
    footer_newsletter_title character varying(255),
    footer_newsletter_description text,
    legal_mentions text,
    privacy_policy text,
    terms_of_use text
);


ALTER TABLE public.site_settings OWNER TO directus;

--
-- Name: stats; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.stats (
    id uuid NOT NULL,
    sort integer,
    status character varying(255) DEFAULT 'published'::character varying,
    value integer,
    suffix character varying(255) DEFAULT ''::character varying,
    label character varying(255)
);


ALTER TABLE public.stats OWNER TO directus;

--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.testimonials (
    id uuid NOT NULL,
    status character varying(255) DEFAULT 'draft'::character varying,
    sort integer,
    quote text,
    name character varying(255),
    role character varying(255),
    company character varying(255),
    avatar uuid
);


ALTER TABLE public.testimonials OWNER TO directus;

--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.applications (id, status, date_created, first_name, last_name, email, phone, country, job_title, job_slug, motivation, cv) FROM stdin;
98d36d5b-a158-4416-9c9c-d5f1863f2426	new	2026-02-04 20:32:18.788+00	Okalaon Marius	Djenontin	minhadjenotinmarius@gmail.com	+33650578737	France	Développeur Full-Stack Senior	developpeur-fullstack-senior	\N	79ce463c-8e10-4735-86d8-f1e159c5cbd0
0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	pending	2026-02-06 09:22:14.279+00	Jean	Dupont	minhadjenontin@gmail.com	+33612345678	France	Développeur Full Stack	developpeur-fullstack	Candidature test pour vérifier les flux Directus.	\N
\.


--
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.blog_posts (id, status, sort, date_created, date_updated, title, slug, excerpt, content, date_published, author, tags, cover_image) FROM stdin;
ae96ffc9-2863-4051-8186-fa1db62fe7e1	published	2	2026-02-04 17:52:23.565+00	\N	Cloud souverain : pourquoi repenser son hébergement	cloud-souverain-hebergement	La souveraineté des données est un enjeu majeur. Explorons pourquoi un cloud adapté aux réalités locales est essentiel pour les entreprises.	<p>La question de la souveraineté numérique n'a jamais été aussi pertinente. Alors que les données deviennent le nouvel or noir, les entreprises doivent s'interroger sur où et comment leurs données sont stockées.</p><h2>Les enjeux de la localisation des données</h2><p>Héberger ses données sur des serveurs distants pose des questions juridiques, de performance et de sécurité. Les latences réseau, la conformité aux réglementations locales et la dépendance à des fournisseurs étrangers sont autant de défis à relever.</p><h2>Une infrastructure adaptée</h2><p>DommCloud a été pensé pour offrir une alternative crédible. En proposant des solutions d'hébergement optimisées, nous garantissons des performances élevées, une conformité réglementaire et un support de proximité.</p><h2>Vers une autonomie numérique</h2><p>L'avenir du cloud passe par le développement d'infrastructures locales de qualité. C'est un investissement stratégique qui permettra aux entreprises de garder le contrôle sur leurs données tout en bénéficiant des avantages du cloud computing.</p>	2026-01-20 14:00:00+00	Équipe DOMMSOFT	["Cloud","Souveraineté","Infrastructure"]	\N
f307be56-5f9d-4c5b-995d-eb4f9b2fbbd5	published	3	2026-02-04 17:52:23.574+00	\N	Digitaliser la gestion RH : un levier de croissance pour les PME	digitaliser-gestion-rh-pme	La gestion des ressources humaines reste un défi pour de nombreuses PME. Découvrez comment la digitalisation peut simplifier vos processus.	<p>Pour beaucoup de PME, la gestion des ressources humaines reste un processus manuel, chronophage et source d'erreurs. Fiches de paie calculées à la main, suivi des congés sur tableur, absence de reporting... Ces pratiques freinent la croissance.</p><h2>Les bénéfices concrets de la digitalisation</h2><p>Automatiser la gestion RH permet de réduire les erreurs de calcul de paie, de centraliser les informations collaborateurs, de suivre les performances en temps réel et de se conformer facilement aux obligations légales.</p><h2>DommHR : pensé pour les réalités locales</h2><p>DommHR intègre les spécificités réglementaires locales : calcul automatique des cotisations sociales, gestion multi-devises et interface disponible en français.</p><h2>Un investissement rentable</h2><p>Le retour sur investissement d'un outil RH digital se mesure rapidement : gain de temps, réduction des erreurs, meilleure satisfaction des collaborateurs et prise de décision éclairée grâce aux données.</p>	2026-01-12 09:00:00+00	Équipe DOMMSOFT	["RH","Digitalisation","PME"]	\N
97759a4e-2232-4a71-8a76-fd758ffee3c0	published	4	2026-02-04 17:52:23.577+00	\N	E-commerce : les clés pour réussir sa boutique en ligne	ecommerce-cles-reussite	Le e-commerce est en plein essor. Voici les facteurs clés de succès pour lancer et développer une boutique en ligne performante.	<p>Le marché du e-commerce continue sa croissance fulgurante. Cette dynamique représente une opportunité immense pour les entrepreneurs qui sauront s'adapter aux spécificités de leur marché.</p><h2>Comprendre son marché</h2><p>Le e-commerce a ses propres codes selon les régions. Le paiement à la livraison reste dominant dans de nombreux marchés, la logistique du dernier kilomètre est un défi majeur, et la confiance se construit progressivement.</p><h2>Choisir les bons outils</h2><p>Une plateforme e-commerce adaptée doit intégrer les moyens de paiement locaux, proposer une gestion logistique flexible et offrir une expérience mobile-first, la majorité du trafic provenant des smartphones.</p><h2>DommShop : votre allié e-commerce</h2><p>Avec DommShop, nous avons créé une plateforme qui répond à ces exigences. Intégration native de DommPay pour les paiements, gestion de catalogue intuitive, et outils marketing intégrés pour développer votre audience.</p>	2026-01-05 11:00:00+00	Équipe DOMMSOFT	["E-commerce","Entrepreneuriat","Digital"]	\N
399e5f59-5281-47b5-bd51-1e02c0f97e02	published	5	2026-02-04 17:52:23.58+00	\N	5 tendances tech à suivre en 2026 pour les entreprises innovantes	tendances-tech-2026-entreprises	Intelligence artificielle, edge computing, fintech embarquée... Tour d'horizon des tendances technologiques qui façonneront l'année 2026.	<p>L'année 2026 s'annonce riche en innovations technologiques. Pour les entreprises qui veulent rester compétitives, il est essentiel de comprendre et d'anticiper ces évolutions.</p><h2>1. L'IA générative au service des métiers</h2><p>Au-delà du buzz, l'IA générative commence à trouver des applications concrètes en entreprise : automatisation du support client, génération de contenu, analyse prédictive et optimisation des processus.</p><h2>2. La fintech embarquée</h2><p>Les services financiers s'intègrent directement dans les applications non-financières. Paiement, crédit, assurance : ces fonctionnalités deviennent des briques que toute plateforme peut intégrer.</p><h2>3. L'edge computing</h2><p>Avec la multiplication des objets connectés et le besoin de temps réel, le traitement des données se rapproche de leur source de production.</p><h2>4. La cybersécurité proactive</h2><p>Face à la sophistication croissante des menaces, les entreprises passent d'une approche réactive à une posture proactive, avec des outils de détection et de réponse automatisés.</p><h2>5. Le low-code/no-code</h2><p>Ces plateformes démocratisent le développement d'applications et permettent aux équipes métier de créer leurs propres outils sans dépendre entièrement des développeurs.</p>	2025-12-28 08:00:00+00	Équipe DOMMSOFT	["Tendances","Innovation","Tech"]	\N
5b444ec8-5a61-4abe-ad30-bd0af5916dd3	published	1	2026-02-04 17:52:23.544+00	2026-02-04 22:55:36.295+00	Comment le paiement mobile transforme le commerce en Afrique	paiement-mobile-commerce-afrique	Le paiement mobile connaît une croissance exponentielle. Découvrez comment cette révolution redéfinit les échanges commerciaux et ouvre de nouvelles opportunités.	<p><img src="http://localhost:8055/assets/752de803-5294-4947-930b-5dc379152447.png?width=2880&amp;height=1800" alt="Capture D&rsquo;écran 2026 01 08 À 00.05.44"></p>\n<p>Le paiement mobile est en train de transformer radicalement la mani&egrave;re dont les transactions commerciales sont effectu&eacute;es. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une r&eacute;f&eacute;rence mondiale.</p>\n<h2>Une adoption sans pr&eacute;c&eacute;dent</h2>\n<p>Le mobile money s'est impos&eacute; comme le moyen de paiement digital de r&eacute;f&eacute;rence dans de nombreux march&eacute;s. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connect&eacute;e, un faible taux de bancarisation traditionnelle, et des solutions adapt&eacute;es aux r&eacute;alit&eacute;s locales.</p>\n<h2>L'impact sur le commerce</h2>\n<p>Les commer&ccedil;ants b&eacute;n&eacute;ficient d&eacute;sormais d'outils qui leur permettent d'accepter des paiements de mani&egrave;re s&eacute;curis&eacute;e et instantan&eacute;e. Cette digitalisation des &eacute;changes favorise la tra&ccedil;abilit&eacute;, r&eacute;duit les risques li&eacute;s au cash et ouvre l'acc&egrave;s &agrave; de nouveaux march&eacute;s.</p>\n<h2>DommPay au c&oelig;ur de cette transformation</h2>\n<p>Chez DOMMSOFT, nous avons con&ccedil;u DommPay pour r&eacute;pondre pr&eacute;cis&eacute;ment &agrave; ces enjeux. Notre solution int&egrave;gre les principaux op&eacute;rateurs mobile money et offre une exp&eacute;rience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>	2026-01-28 10:00:00+00	Équipe DOMMSOFT	["Paiement","Mobile Money","Fintech"]	55a318cc-ae6b-48a6-9865-3bbc83f20982
\.


--
-- Data for Name: contacts; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.contacts (id, status, date_created, name, email, subject, message, notes) FROM stdin;
3f2ecdb6-3444-4362-b440-0712e71c0904	new	2026-02-04 17:09:59.101+00	Test User	test@test.com	Test	Ceci est un test	\N
1acbbeb6-b6dd-4b0a-adee-7b6d362c8e82	new	2026-02-04 17:10:04.369+00	Test User	test@test.com	Test	Ceci est un test	\N
535d737b-23d1-40fd-9f20-e927fc4d22d6	new	2026-02-04 17:21:02.735+00	Okalaon Marius Djenontin	minhadjenotinmarius@gmail.com	ffdsfsdfsdf	dsfdsfdsfdsfdsfsd	\N
76129039-ac72-452d-a225-fa2c1b2f4b46	new	2026-02-04 17:22:38.364+00	Okalaon Marius Djenontin	minhadjenotinmarius@gmail.com	ffdsfsdfsdf	sqSQsqSqs	\N
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
a4363212-fee3-4c2e-b0e4-eb491113c7c0	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
10bd0e0b-1a52-441c-992b-7c805a6147b9	988ce776-97f5-4b0a-a973-976491e7ebca	\N	cee9e31d-bed2-495d-88c8-07deb57e052d	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 16:59:20.79+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	http://localhost:8055
2	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:00:27.676+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
3	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:03:36.73+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
4	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.41+00	192.168.65.1	curl/8.7.1	directus_fields	1	\N
5	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.589+00	192.168.65.1	curl/8.7.1	directus_fields	2	\N
6	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.621+00	192.168.65.1	curl/8.7.1	directus_fields	3	\N
7	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.633+00	192.168.65.1	curl/8.7.1	directus_fields	4	\N
8	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.645+00	192.168.65.1	curl/8.7.1	directus_fields	5	\N
9	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.701+00	192.168.65.1	curl/8.7.1	directus_fields	6	\N
10	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.719+00	192.168.65.1	curl/8.7.1	directus_fields	7	\N
11	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.735+00	192.168.65.1	curl/8.7.1	directus_fields	8	\N
12	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.741+00	192.168.65.1	curl/8.7.1	directus_fields	9	\N
13	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.749+00	192.168.65.1	curl/8.7.1	directus_fields	10	\N
14	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.755+00	192.168.65.1	curl/8.7.1	directus_fields	11	\N
15	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.766+00	192.168.65.1	curl/8.7.1	directus_fields	12	\N
16	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:29.775+00	192.168.65.1	curl/8.7.1	directus_collections	products	\N
17	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:51.818+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
18	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:51.986+00	192.168.65.1	curl/8.7.1	directus_fields	13	\N
19	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.004+00	192.168.65.1	curl/8.7.1	directus_fields	14	\N
20	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.008+00	192.168.65.1	curl/8.7.1	directus_fields	15	\N
21	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.02+00	192.168.65.1	curl/8.7.1	directus_fields	16	\N
22	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.033+00	192.168.65.1	curl/8.7.1	directus_fields	17	\N
23	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.053+00	192.168.65.1	curl/8.7.1	directus_fields	18	\N
24	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.083+00	192.168.65.1	curl/8.7.1	directus_fields	19	\N
25	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.114+00	192.168.65.1	curl/8.7.1	directus_fields	20	\N
26	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.127+00	192.168.65.1	curl/8.7.1	directus_fields	21	\N
27	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.144+00	192.168.65.1	curl/8.7.1	directus_fields	22	\N
28	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.16+00	192.168.65.1	curl/8.7.1	directus_fields	23	\N
29	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.175+00	192.168.65.1	curl/8.7.1	directus_fields	24	\N
30	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.188+00	192.168.65.1	curl/8.7.1	directus_fields	25	\N
31	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:05:52.202+00	192.168.65.1	curl/8.7.1	directus_collections	blog_posts	\N
32	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.327+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
33	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.702+00	192.168.65.1	curl/8.7.1	directus_fields	26	\N
34	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.707+00	192.168.65.1	curl/8.7.1	directus_fields	27	\N
35	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.71+00	192.168.65.1	curl/8.7.1	directus_fields	28	\N
36	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.718+00	192.168.65.1	curl/8.7.1	directus_fields	29	\N
37	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.721+00	192.168.65.1	curl/8.7.1	directus_fields	30	\N
38	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.725+00	192.168.65.1	curl/8.7.1	directus_fields	31	\N
39	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.728+00	192.168.65.1	curl/8.7.1	directus_fields	32	\N
40	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.732+00	192.168.65.1	curl/8.7.1	directus_fields	33	\N
41	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:04.734+00	192.168.65.1	curl/8.7.1	directus_collections	contacts	\N
42	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.192+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
43	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.61+00	192.168.65.1	curl/8.7.1	directus_fields	34	\N
44	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.624+00	192.168.65.1	curl/8.7.1	directus_fields	35	\N
45	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.629+00	192.168.65.1	curl/8.7.1	directus_fields	36	\N
46	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.635+00	192.168.65.1	curl/8.7.1	directus_fields	37	\N
47	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.641+00	192.168.65.1	curl/8.7.1	directus_fields	38	\N
48	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.644+00	192.168.65.1	curl/8.7.1	directus_fields	39	\N
49	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.646+00	192.168.65.1	curl/8.7.1	directus_fields	40	\N
50	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.651+00	192.168.65.1	curl/8.7.1	directus_fields	41	\N
51	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.657+00	192.168.65.1	curl/8.7.1	directus_collections	testimonials	\N
52	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.741+00	192.168.65.1	curl/8.7.1	directus_fields	42	\N
53	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.744+00	192.168.65.1	curl/8.7.1	directus_fields	43	\N
54	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.748+00	192.168.65.1	curl/8.7.1	directus_fields	44	\N
55	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.753+00	192.168.65.1	curl/8.7.1	directus_fields	45	\N
56	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.757+00	192.168.65.1	curl/8.7.1	directus_fields	46	\N
57	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.759+00	192.168.65.1	curl/8.7.1	directus_fields	47	\N
58	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.762+00	192.168.65.1	curl/8.7.1	directus_fields	48	\N
59	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.768+00	192.168.65.1	curl/8.7.1	directus_fields	49	\N
60	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.776+00	192.168.65.1	curl/8.7.1	directus_fields	50	\N
61	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.787+00	192.168.65.1	curl/8.7.1	directus_fields	51	\N
62	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.79+00	192.168.65.1	curl/8.7.1	directus_fields	52	\N
63	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.792+00	192.168.65.1	curl/8.7.1	directus_fields	53	\N
64	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.795+00	192.168.65.1	curl/8.7.1	directus_fields	54	\N
65	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.8+00	192.168.65.1	curl/8.7.1	directus_fields	55	\N
66	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:06:37.808+00	192.168.65.1	curl/8.7.1	directus_collections	site_settings	\N
67	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:07:13.754+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
68	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:07:45.472+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
69	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:08:22.665+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
70	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:37.513+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
71	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:48.751+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
72	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.162+00	192.168.65.1	curl/8.7.1	directus_permissions	1	\N
73	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.285+00	192.168.65.1	curl/8.7.1	directus_permissions	2	\N
74	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.436+00	192.168.65.1	curl/8.7.1	directus_permissions	3	\N
75	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.485+00	192.168.65.1	curl/8.7.1	directus_permissions	4	\N
76	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.528+00	192.168.65.1	curl/8.7.1	directus_permissions	5	\N
77	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:09:49.583+00	192.168.65.1	curl/8.7.1	directus_permissions	6	\N
78	create	\N	2026-02-04 17:09:59.105+00	192.168.65.1	curl/8.7.1	contacts	3f2ecdb6-3444-4362-b440-0712e71c0904	\N
79	create	\N	2026-02-04 17:10:04.377+00	192.168.65.1	curl/8.7.1	contacts	1acbbeb6-b6dd-4b0a-adee-7b6d362c8e82	\N
80	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:10:51.012+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
81	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:09.868+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
82	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:10.045+00	192.168.65.1	curl/8.7.1	products	2a2fbf26-930b-42ec-881d-49ed6327e6f9	\N
83	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:10.058+00	192.168.65.1	curl/8.7.1	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	\N
84	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:10.061+00	192.168.65.1	curl/8.7.1	products	c5ce8492-a63a-4f34-a099-8368179a57ec	\N
85	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:10.077+00	192.168.65.1	curl/8.7.1	products	446bd54e-a33c-4fc3-8e02-589b4dbf9979	\N
86	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:41.275+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
87	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:14:41.626+00	192.168.65.1	curl/8.7.1	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	\N
88	create	\N	2026-02-04 17:21:02.761+00	192.168.65.1	node	contacts	535d737b-23d1-40fd-9f20-e927fc4d22d6	\N
89	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:21:53.863+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	products	446bd54e-a33c-4fc3-8e02-589b4dbf9979	http://localhost:8055
90	create	\N	2026-02-04 17:22:38.385+00	192.168.65.1	node	contacts	76129039-ac72-452d-a225-fa2c1b2f4b46	\N
91	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.33+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
92	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.79+00	192.168.65.1	curl/8.7.1	directus_fields	56	\N
93	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.797+00	192.168.65.1	curl/8.7.1	directus_fields	57	\N
94	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.803+00	192.168.65.1	curl/8.7.1	directus_fields	58	\N
95	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.815+00	192.168.65.1	curl/8.7.1	directus_collections	newsletter_subscribers	\N
96	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:54.948+00	192.168.65.1	curl/8.7.1	directus_permissions	7	\N
97	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:36:55.023+00	192.168.65.1	curl/8.7.1	directus_fields	59	\N
98	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:37:35.377+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
99	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:37:47.463+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
100	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:38:15.535+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
101	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:38:15.992+00	192.168.65.1	curl/8.7.1	products	2b2969f9-a2d2-453e-adb6-53e6236b18f7	\N
102	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:38:16.024+00	192.168.65.1	curl/8.7.1	products	2a2fbf26-930b-42ec-881d-49ed6327e6f9	\N
103	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:38:16.063+00	192.168.65.1	curl/8.7.1	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	\N
104	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:38:16.091+00	192.168.65.1	curl/8.7.1	products	c5ce8492-a63a-4f34-a099-8368179a57ec	\N
105	create	\N	2026-02-04 17:50:11.409+00	192.168.65.1	node	newsletter_subscribers	9a46a93e-f0e1-45e3-96fd-324b7d9cbd59	\N
106	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.246+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
107	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.549+00	192.168.65.1	Python-urllib/3.12	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	\N
108	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.569+00	192.168.65.1	Python-urllib/3.12	blog_posts	ae96ffc9-2863-4051-8186-fa1db62fe7e1	\N
109	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.575+00	192.168.65.1	Python-urllib/3.12	blog_posts	f307be56-5f9d-4c5b-995d-eb4f9b2fbbd5	\N
110	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.578+00	192.168.65.1	Python-urllib/3.12	blog_posts	97759a4e-2232-4a71-8a76-fd758ffee3c0	\N
111	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:52:23.581+00	192.168.65.1	Python-urllib/3.12	blog_posts	399e5f59-5281-47b5-bd51-1e02c0f97e02	\N
112	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:54:39.169+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
113	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:55:15.698+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
114	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:55:44.041+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	22	http://localhost:8055
115	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:57:10.2+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
116	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:57:19.374+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
117	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:57:19.844+00	192.168.65.1	Python-urllib/3.12	directus_fields	22	\N
118	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:57:19.932+00	192.168.65.1	Python-urllib/3.12	directus_fields	60	\N
119	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:57:33.131+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
120	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:59:08.251+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
121	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:59:08.649+00	192.168.65.1	Python-urllib/3.12	directus_fields	60	\N
122	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:59:18.033+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
123	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:59:18.481+00	192.168.65.1	Python-urllib/3.12	directus_fields	61	\N
124	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 17:59:53.071+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	61	http://localhost:8055
125	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 18:02:02.265+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_folders	636a26fa-1c70-4f9e-a125-100f2af93883	http://localhost:8055
126	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 18:02:26.425+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	62	http://localhost:8055
127	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 18:02:46.562+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	55a318cc-ae6b-48a6-9865-3bbc83f20982	http://localhost:8055
128	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 18:02:49.188+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	http://localhost:8055
129	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:43.564+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
130	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.09+00	192.168.65.1	Python-urllib/3.12	directus_fields	63	\N
131	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.109+00	192.168.65.1	Python-urllib/3.12	directus_fields	64	\N
132	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.135+00	192.168.65.1	Python-urllib/3.12	directus_fields	65	\N
133	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.147+00	192.168.65.1	Python-urllib/3.12	directus_fields	66	\N
134	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.149+00	192.168.65.1	Python-urllib/3.12	directus_fields	67	\N
135	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.152+00	192.168.65.1	Python-urllib/3.12	directus_fields	68	\N
136	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.159+00	192.168.65.1	Python-urllib/3.12	directus_fields	69	\N
137	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.173+00	192.168.65.1	Python-urllib/3.12	directus_fields	70	\N
138	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.183+00	192.168.65.1	Python-urllib/3.12	directus_fields	71	\N
139	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.197+00	192.168.65.1	Python-urllib/3.12	directus_fields	72	\N
140	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.205+00	192.168.65.1	Python-urllib/3.12	directus_fields	73	\N
141	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.211+00	192.168.65.1	Python-urllib/3.12	directus_fields	74	\N
142	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.219+00	192.168.65.1	Python-urllib/3.12	directus_fields	75	\N
143	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.223+00	192.168.65.1	Python-urllib/3.12	directus_collections	job_offers	\N
144	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:13:44.403+00	192.168.65.1	Python-urllib/3.12	directus_permissions	8	\N
145	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:14:31.657+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
146	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:14:32.105+00	192.168.65.1	Python-urllib/3.12	job_offers	60f53ced-681e-440b-aa6d-dd683fa3a202	\N
147	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:14:32.166+00	192.168.65.1	Python-urllib/3.12	job_offers	c550eba6-00ef-403e-b3b8-c0223dce56d8	\N
148	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:14:32.19+00	192.168.65.1	Python-urllib/3.12	job_offers	c498ecb2-2677-475f-8538-9acea310f4b1	\N
149	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.141+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
150	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.464+00	192.168.65.1	Python-urllib/3.12	directus_fields	76	\N
151	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.479+00	192.168.65.1	Python-urllib/3.12	directus_fields	77	\N
152	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.488+00	192.168.65.1	Python-urllib/3.12	directus_fields	78	\N
153	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.494+00	192.168.65.1	Python-urllib/3.12	directus_fields	79	\N
154	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.499+00	192.168.65.1	Python-urllib/3.12	directus_fields	80	\N
155	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.503+00	192.168.65.1	Python-urllib/3.12	directus_fields	81	\N
156	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.506+00	192.168.65.1	Python-urllib/3.12	directus_fields	82	\N
157	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.507+00	192.168.65.1	Python-urllib/3.12	directus_fields	83	\N
158	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.515+00	192.168.65.1	Python-urllib/3.12	directus_fields	84	\N
159	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.518+00	192.168.65.1	Python-urllib/3.12	directus_fields	85	\N
160	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.523+00	192.168.65.1	Python-urllib/3.12	directus_fields	86	\N
161	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.53+00	192.168.65.1	Python-urllib/3.12	directus_collections	applications	\N
162	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 19:55:30.681+00	192.168.65.1	Python-urllib/3.12	directus_fields	87	\N
163	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:01:21.988+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	job_offers	c550eba6-00ef-403e-b3b8-c0223dce56d8	http://localhost:8055
164	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:22:03.331+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
165	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:22:03.581+00	192.168.65.1	Python-urllib/3.12	directus_fields	88	\N
166	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:22:03.878+00	192.168.65.1	Python-urllib/3.12	directus_fields	89	\N
167	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:22:03.993+00	192.168.65.1	Python-urllib/3.12	directus_fields	90	\N
168	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:22:04.073+00	192.168.65.1	Python-urllib/3.12	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	\N
169	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:28:36.87+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_collections	applications	http://localhost:8055
170	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:30:45.593+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	products	2a2fbf26-930b-42ec-881d-49ed6327e6f9	http://localhost:8055
171	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:32:18.12+00	192.168.65.1	node	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
172	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:32:18.529+00	192.168.65.1	node	directus_files	79ce463c-8e10-4735-86d8-f1e159c5cbd0	\N
173	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:32:18.791+00	192.168.65.1	node	applications	98d36d5b-a158-4416-9c9c-d5f1863f2426	\N
174	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:30:30.725+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
175	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:30:30.855+00	192.168.65.1	Python-urllib/3.12	directus_collections	products	\N
176	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:37.631+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	12	http://localhost:8055
177	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:46.7+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	91	http://localhost:8055
178	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.479+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	1	http://localhost:8055
179	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.49+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	2	http://localhost:8055
180	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.497+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	3	http://localhost:8055
181	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.508+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	4	http://localhost:8055
182	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.514+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	5	http://localhost:8055
183	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.531+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	6	http://localhost:8055
184	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.536+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	7	http://localhost:8055
185	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.541+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	8	http://localhost:8055
186	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.544+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	9	http://localhost:8055
187	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.549+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	91	http://localhost:8055
188	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.551+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	10	http://localhost:8055
189	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.556+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	11	http://localhost:8055
190	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:35:52.561+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	59	http://localhost:8055
191	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:04.44+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	2a43a3f1-63dd-41f1-8042-d63451eaad23	http://localhost:8055
192	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:06.832+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	http://localhost:8055
193	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:27.85+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	752de803-5294-4947-930b-5dc379152447	http://localhost:8055
194	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:29.232+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	products	c5ce8492-a63a-4f34-a099-8368179a57ec	http://localhost:8055
195	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:55:36.305+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	http://localhost:8055
196	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 15:56:02.315+00	162.159.140.98	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	http://localhost:8055
197	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 15:59:21.336+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
198	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 15:59:36.635+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
199	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:32.651+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
200	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:33.056+00	192.168.65.1	curl/8.7.1	directus_flows	3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	\N
201	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:42.729+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
202	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:43.087+00	192.168.65.1	curl/8.7.1	directus_operations	54dced3b-2149-4e47-9470-9d43058ad9dd	\N
203	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:49.986+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
204	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:00:50.429+00	192.168.65.1	curl/8.7.1	directus_flows	3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	\N
205	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:12.387+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
206	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:12.79+00	192.168.65.1	curl/8.7.1	directus_flows	47382480-b09f-4b82-bc6d-ba32ae593bc7	\N
207	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:28.638+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
208	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:38.026+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
209	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:48.292+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
210	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:48.642+00	192.168.65.1	curl/8.7.1	directus_operations	1da568e1-d35b-4424-8d0b-7a336e99bb06	\N
212	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:02:00.268+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
213	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:02:00.704+00	192.168.65.1	curl/8.7.1	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	\N
215	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:02:00.797+00	192.168.65.1	curl/8.7.1	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	\N
211	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:01:48.69+00	192.168.65.1	curl/8.7.1	directus_flows	47382480-b09f-4b82-bc6d-ba32ae593bc7	\N
214	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:02:00.748+00	192.168.65.1	curl/8.7.1	directus_operations	ea77d55b-08c4-4213-abda-0e07d4cdef1c	\N
216	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:02:09.475+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
217	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:05:37.697+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
218	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:06:02.515+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
219	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:06:22.133+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
220	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:07:03.301+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
221	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:07:03.751+00	192.168.65.1	curl/8.7.1	directus_settings	1	\N
222	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:07:38.197+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
223	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:07:38.601+00	192.168.65.1	curl/8.7.1	directus_settings	1	\N
224	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:09:04.363+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
225	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:09:04.697+00	192.168.65.1	curl/8.7.1	directus_settings	1	\N
226	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-05 16:10:33.135+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
227	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:06:21.172+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	http://localhost:8055
228	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:10:11.657+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
229	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:10:17.681+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
230	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:10:23.518+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
231	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:10:49.615+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
232	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:11:01.461+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
233	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:11:23.402+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
234	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:11:23.73+00	192.168.65.1	curl/8.7.1	directus_flows	dffa8e0b-6c1b-4115-a8c0-a7ae476d908f	\N
235	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:11:23.796+00	192.168.65.1	curl/8.7.1	directus_operations	70ce8f80-3e4a-407d-8f4f-090cbce2df2d	\N
236	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:11:37.665+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
237	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:19.61+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
238	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:20.069+00	192.168.65.1	Python-urllib/3.12	directus_operations	70ce8f80-3e4a-407d-8f4f-090cbce2df2d	\N
239	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.197+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
240	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.613+00	192.168.65.1	Python-urllib/3.12	directus_flows	dffa8e0b-6c1b-4115-a8c0-a7ae476d908f	\N
241	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.633+00	192.168.65.1	Python-urllib/3.12	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	\N
242	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.666+00	192.168.65.1	Python-urllib/3.12	directus_operations	20001c38-f49a-4857-9cd5-287ba6461c4d	\N
243	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.691+00	192.168.65.1	Python-urllib/3.12	directus_operations	8773f070-f588-4963-a514-2dde2582186f	\N
244	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.71+00	192.168.65.1	Python-urllib/3.12	directus_operations	a9821a29-f132-420d-bf7e-788e88fe5a81	\N
245	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.851+00	192.168.65.1	Python-urllib/3.12	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	\N
246	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.931+00	192.168.65.1	Python-urllib/3.12	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	\N
247	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:31.983+00	192.168.65.1	Python-urllib/3.12	directus_operations	caf1a645-4b29-4710-97f0-3c4c5095e76b	\N
248	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:32.052+00	192.168.65.1	Python-urllib/3.12	directus_operations	cf5010c8-58cb-4e9b-b85e-491007a045ab	\N
249	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:32.068+00	192.168.65.1	Python-urllib/3.12	directus_operations	092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3	\N
250	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:32.09+00	192.168.65.1	Python-urllib/3.12	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	\N
251	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:12:41.829+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
252	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:37.924+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
253	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:54.517+00	192.168.65.1	Python-urllib/3.12	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
254	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:54.949+00	192.168.65.1	Python-urllib/3.12	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	\N
255	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.006+00	192.168.65.1	Python-urllib/3.12	directus_operations	8773f070-f588-4963-a514-2dde2582186f	\N
256	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.044+00	192.168.65.1	Python-urllib/3.12	directus_operations	a9821a29-f132-420d-bf7e-788e88fe5a81	\N
257	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.065+00	192.168.65.1	Python-urllib/3.12	directus_operations	20001c38-f49a-4857-9cd5-287ba6461c4d	\N
258	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.077+00	192.168.65.1	Python-urllib/3.12	directus_operations	8773f070-f588-4963-a514-2dde2582186f	\N
259	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.098+00	192.168.65.1	Python-urllib/3.12	directus_operations	a9821a29-f132-420d-bf7e-788e88fe5a81	\N
260	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.11+00	192.168.65.1	Python-urllib/3.12	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	\N
261	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.135+00	192.168.65.1	Python-urllib/3.12	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	\N
262	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.17+00	192.168.65.1	Python-urllib/3.12	directus_operations	092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3	\N
263	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.19+00	192.168.65.1	Python-urllib/3.12	directus_operations	cf5010c8-58cb-4e9b-b85e-491007a045ab	\N
269	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.306+00	192.168.65.1	Python-urllib/3.12	directus_operations	a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f	\N
271	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.371+00	192.168.65.1	Python-urllib/3.12	directus_operations	3020d7db-904d-4d59-b756-e8194e509185	\N
272	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.454+00	192.168.65.1	Python-urllib/3.12	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	\N
275	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.511+00	192.168.65.1	Python-urllib/3.12	directus_operations	b3b957d3-1529-4c1b-aa52-a84fd489e964	\N
276	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.533+00	192.168.65.1	Python-urllib/3.12	directus_operations	fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92	\N
264	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.209+00	192.168.65.1	Python-urllib/3.12	directus_operations	092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3	\N
265	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.226+00	192.168.65.1	Python-urllib/3.12	directus_operations	caf1a645-4b29-4710-97f0-3c4c5095e76b	\N
266	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.241+00	192.168.65.1	Python-urllib/3.12	directus_operations	cf5010c8-58cb-4e9b-b85e-491007a045ab	\N
267	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.251+00	192.168.65.1	Python-urllib/3.12	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	\N
268	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.277+00	192.168.65.1	Python-urllib/3.12	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	\N
270	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.327+00	192.168.65.1	Python-urllib/3.12	directus_operations	d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa	\N
273	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.479+00	192.168.65.1	Python-urllib/3.12	directus_flows	ebd58ddf-7b37-446e-ada8-5fb0866902da	\N
274	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.499+00	192.168.65.1	Python-urllib/3.12	directus_operations	b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a	\N
277	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:15:55.545+00	192.168.65.1	Python-urllib/3.12	directus_flows	ebd58ddf-7b37-446e-ada8-5fb0866902da	\N
278	run	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:16:37.314+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	http://localhost:8055
279	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:22:13.878+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
280	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:22:14.281+00	192.168.65.1	curl/8.7.1	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	\N
281	run	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:22:14.331+00	192.168.65.1	curl/8.7.1	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	\N
282	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:22:31.618+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
283	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:08.102+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
284	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:08.544+00	192.168.65.1	curl/8.7.1	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	\N
285	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:25.969+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
286	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.35+00	192.168.65.1	curl/8.7.1	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	\N
287	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.394+00	192.168.65.1	curl/8.7.1	directus_operations	873ad65d-3428-4b38-b0cd-3800a9d0ad6d	\N
288	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.479+00	192.168.65.1	curl/8.7.1	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	\N
289	run	\N	2026-02-06 09:23:26.524+00	192.168.65.1	curl/8.7.1	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	\N
290	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.553+00	192.168.65.1	curl/8.7.1	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	\N
291	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.596+00	192.168.65.1	curl/8.7.1	directus_operations	873ad65d-3428-4b38-b0cd-3800a9d0ad6d	\N
292	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:23:26.665+00	192.168.65.1	curl/8.7.1	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	\N
293	run	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:24:36.434+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	http://localhost:8055
294	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:32:08.842+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
295	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:32:16.135+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
296	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:34:12.46+00	192.168.65.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
297	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-06 09:34:12.923+00	192.168.65.1	curl/8.7.1	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	\N
298	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 15:49:46.144+00	172.19.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	http://localhost:8055
299	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:01:57.304+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
300	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:02:12.77+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
301	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:02:29.338+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
302	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:02:37.718+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
303	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:03:51.623+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
304	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:03:52.083+00	172.19.0.1	curl/8.7.1	directus_fields	92	\N
305	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:04:03.772+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
306	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:04:04.201+00	172.19.0.1	curl/8.7.1	directus_fields	93	\N
307	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:04:44.606+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
308	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:04:45.035+00	172.19.0.1	curl/8.7.1	products	e843568b-1d7e-429b-811b-fb0ff92bde37	\N
309	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:07:53.487+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
310	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:07:53.895+00	172.19.0.1	curl/8.7.1	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	\N
311	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:07:53.95+00	172.19.0.1	curl/8.7.1	products	c5ce8492-a63a-4f34-a099-8368179a57ec	\N
312	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:17:07.813+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
313	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:17:08.182+00	172.19.0.1	curl/8.7.1	directus_fields	94	\N
314	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:19:56.821+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
315	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:19:57.175+00	172.19.0.1	curl/8.7.1	products	e843568b-1d7e-429b-811b-fb0ff92bde37	\N
316	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:19:57.213+00	172.19.0.1	curl/8.7.1	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	\N
317	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:19:57.248+00	172.19.0.1	curl/8.7.1	products	c5ce8492-a63a-4f34-a099-8368179a57ec	\N
318	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:27:51.773+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
319	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:27:59.704+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
320	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:14.432+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
321	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:14.913+00	172.19.0.1	curl/8.7.1	directus_fields	94	\N
322	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:32.39+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
323	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:44.981+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
324	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:45.425+00	172.19.0.1	curl/8.7.1	products	e843568b-1d7e-429b-811b-fb0ff92bde37	\N
325	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:45.453+00	172.19.0.1	curl/8.7.1	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	\N
326	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:45.475+00	172.19.0.1	curl/8.7.1	products	c5ce8492-a63a-4f34-a099-8368179a57ec	\N
327	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:28:45.502+00	172.19.0.1	curl/8.7.1	products	2b2969f9-a2d2-453e-adb6-53e6236b18f7	\N
328	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:29:31.192+00	172.19.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	http://localhost:8055
329	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:30:41.069+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
330	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:31:50.101+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
331	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:31:50.515+00	172.19.0.1	curl/8.7.1	directus_fields	95	\N
332	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:35:11.83+00	172.19.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	products	e843568b-1d7e-429b-811b-fb0ff92bde37	http://localhost:8055
333	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:37:37.183+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
334	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:37:49.253+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
335	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:38:38.444+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
336	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:38:38.856+00	172.19.0.1	curl/8.7.1	directus_fields	95	\N
337	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:38:38.955+00	172.19.0.1	curl/8.7.1	directus_fields	91	\N
338	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:38:50.334+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
339	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:39:08.666+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
340	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:40:22.971+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
341	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:42:32.076+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
342	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:42:43.289+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
343	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 16:42:43.719+00	172.19.0.1	curl/8.7.1	directus_fields	91	\N
344	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:01:26.963+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
345	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:01:27.387+00	172.19.0.1	curl/8.7.1	directus_fields	96	\N
346	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:01:27.408+00	172.19.0.1	curl/8.7.1	directus_fields	97	\N
347	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:01:27.411+00	172.19.0.1	curl/8.7.1	directus_fields	98	\N
348	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:01:27.417+00	172.19.0.1	curl/8.7.1	directus_collections	stats	\N
349	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:10.911+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
350	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:11.47+00	172.19.0.1	curl/8.7.1	directus_fields	99	\N
351	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:11.68+00	172.19.0.1	curl/8.7.1	directus_fields	100	\N
352	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:11.815+00	172.19.0.1	curl/8.7.1	directus_fields	101	\N
353	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:34.665+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
354	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:35.131+00	172.19.0.1	curl/8.7.1	stats	25358e7b-7a6b-4610-ab85-029967b554f7	\N
355	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:35.135+00	172.19.0.1	curl/8.7.1	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	\N
356	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:35.136+00	172.19.0.1	curl/8.7.1	stats	61f67f10-f533-4d01-bb29-562c2af3cc95	\N
357	create	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:02:35.138+00	172.19.0.1	curl/8.7.1	stats	75ef6b7a-19d2-417c-94e0-a3672d19e6fe	\N
358	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:04:50.327+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
359	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:05:02.459+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
360	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:05:03.227+00	172.19.0.1	curl/8.7.1	stats	25358e7b-7a6b-4610-ab85-029967b554f7	\N
361	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:05:03.292+00	172.19.0.1	curl/8.7.1	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	\N
362	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:05:03.337+00	172.19.0.1	curl/8.7.1	stats	61f67f10-f533-4d01-bb29-562c2af3cc95	\N
363	delete	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:05:03.374+00	172.19.0.1	curl/8.7.1	stats	75ef6b7a-19d2-417c-94e0-a3672d19e6fe	\N
364	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:18:35.252+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
365	login	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:18:42.908+00	172.19.0.1	curl/8.7.1	directus_users	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N
366	update	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-22 17:18:43.317+00	172.19.0.1	curl/8.7.1	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	\N
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
products	inventory_2	Produits et réalisations DOMMSOFT	\N	f	f	\N	status	t	archived	published	sort	all	\N	\N	\N	\N	open	\N	f
blog_posts	article	Articles de blog et actualités	\N	f	f	\N	status	t	archived	published	sort	all	\N	\N	\N	\N	open	\N	f
contacts	mail	Messages reçus via le formulaire de contact	\N	f	f	\N	status	t	archived	new	\N	all	\N	\N	\N	\N	open	\N	f
testimonials	format_quote	Témoignages clients	\N	f	f	\N	status	t	archived	published	sort	all	\N	\N	\N	\N	open	\N	f
site_settings	settings	Paramètres globaux du site	\N	f	t	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
newsletter_subscribers	mail	Abonnés à la newsletter	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
job_offers	work	\N	\N	f	f	\N	status	t	archived	draft	sort	all	\N	\N	\N	\N	open	\N	f
applications	assignment_ind	\N	\N	f	f	[{"language":"fr-FR","translation":"Candidatures"}]	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
stats	bar_chart	Chiffres cles affiches sur la homepage	\N	f	f	\N	\N	t	\N	\N	sort	all	\N	\N	\N	\N	open	\N	f
\.


--
-- Data for Name: directus_comments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_comments (id, collection, item, comment, date_created, date_updated, user_created, user_updated) FROM stdin;
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_deployment_projects; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_deployment_projects (id, deployment, external_id, name, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_deployment_runs; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_deployment_runs (id, project, external_id, target, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_deployments; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_deployments (id, provider, credentials, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message, searchable) FROM stdin;
13	blog_posts	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
14	blog_posts	status	\N	select-dropdown	{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
15	blog_posts	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N	t
16	blog_posts	date_created	date-created	datetime	\N	\N	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
17	blog_posts	date_updated	date-updated	datetime	\N	\N	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
18	blog_posts	title	\N	input	\N	\N	\N	f	f	6	full	\N	Titre de l article	\N	t	\N	\N	\N	t
19	blog_posts	slug	\N	input	\N	\N	\N	f	f	7	half	\N	URL de l article	\N	t	\N	\N	\N	t
20	blog_posts	excerpt	\N	input-multiline	\N	\N	\N	f	f	8	full	\N	Résumé court affiché dans les listes	\N	f	\N	\N	\N	t
21	blog_posts	content	\N	input-rich-text-html	\N	\N	\N	f	f	9	full	\N	Contenu complet de l article	\N	f	\N	\N	\N	t
23	blog_posts	date_published	\N	datetime	\N	\N	\N	f	f	11	half	\N	Date de publication	\N	f	\N	\N	\N	t
24	blog_posts	author	\N	input	\N	\N	\N	f	f	12	half	\N	Nom de l auteur	\N	f	\N	\N	\N	t
25	blog_posts	tags	cast-json	tags	\N	\N	\N	f	f	13	full	\N	Tags de l article	\N	f	\N	\N	\N	t
26	contacts	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
27	contacts	status	\N	select-dropdown	{"choices":[{"text":"Nouveau","value":"new"},{"text":"Lu","value":"read"},{"text":"Répondu","value":"replied"},{"text":"Archivé","value":"archived"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
28	contacts	date_created	date-created	datetime	\N	\N	\N	t	f	3	half	\N	\N	\N	f	\N	\N	\N	t
29	contacts	name	\N	input	\N	\N	\N	f	f	4	half	\N	Nom complet	\N	t	\N	\N	\N	t
30	contacts	email	\N	input	\N	\N	\N	f	f	5	half	\N	Adresse email	\N	t	\N	\N	\N	t
31	contacts	subject	\N	input	\N	\N	\N	f	f	6	full	\N	Sujet du message	\N	f	\N	\N	\N	t
32	contacts	message	\N	input-multiline	\N	\N	\N	f	f	7	full	\N	Contenu du message	\N	t	\N	\N	\N	t
33	contacts	notes	\N	input-multiline	\N	\N	\N	f	f	8	full	\N	Notes internes (réponse, suivi...)	\N	f	\N	\N	\N	t
34	testimonials	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
35	testimonials	status	\N	select-dropdown	{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
36	testimonials	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N	t
37	testimonials	quote	\N	input-multiline	\N	\N	\N	f	f	4	full	\N	Citation du client	\N	t	\N	\N	\N	t
38	testimonials	name	\N	input	\N	\N	\N	f	f	5	half	\N	Nom du client	\N	t	\N	\N	\N	t
39	testimonials	role	\N	input	\N	\N	\N	f	f	6	half	\N	Poste occupé	\N	f	\N	\N	\N	t
40	testimonials	company	\N	input	\N	\N	\N	f	f	7	half	\N	Entreprise	\N	f	\N	\N	\N	t
41	testimonials	avatar	file	file-image	\N	\N	\N	f	f	8	half	\N	Photo du client	\N	f	\N	\N	\N	t
42	site_settings	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
43	site_settings	hero_title	\N	input	\N	\N	\N	f	f	2	full	\N	Titre principal du Hero	\N	f	\N	\N	\N	t
44	site_settings	hero_subtitle	\N	input	\N	\N	\N	f	f	3	full	\N	Sous-titre du Hero	\N	f	\N	\N	\N	t
45	site_settings	hero_description	\N	input-multiline	\N	\N	\N	f	f	4	full	\N	Description sous le titre	\N	f	\N	\N	\N	t
46	site_settings	hero_badge	\N	input	\N	\N	\N	f	f	5	full	\N	Texte du badge (ex: L innovation au service de tous)	\N	f	\N	\N	\N	t
47	site_settings	cta_primary_text	\N	input	\N	\N	\N	f	f	6	half	\N	Texte du bouton principal	\N	f	\N	\N	\N	t
48	site_settings	cta_primary_url	\N	input	\N	\N	\N	f	f	7	half	\N	Lien du bouton principal	\N	f	\N	\N	\N	t
49	site_settings	cta_secondary_text	\N	input	\N	\N	\N	f	f	8	half	\N	Texte du bouton secondaire	\N	f	\N	\N	\N	t
50	site_settings	cta_secondary_url	\N	input	\N	\N	\N	f	f	9	half	\N	Lien du bouton secondaire	\N	f	\N	\N	\N	t
51	site_settings	social_twitter	\N	input	\N	\N	\N	f	f	10	half	\N	Lien Twitter/X	\N	f	\N	\N	\N	t
52	site_settings	social_linkedin	\N	input	\N	\N	\N	f	f	11	half	\N	Lien LinkedIn	\N	f	\N	\N	\N	t
53	site_settings	social_github	\N	input	\N	\N	\N	f	f	12	half	\N	Lien GitHub	\N	f	\N	\N	\N	t
54	site_settings	footer_newsletter_title	\N	input	\N	\N	\N	f	f	13	full	\N	Titre de la section newsletter	\N	f	\N	\N	\N	t
55	site_settings	footer_newsletter_description	\N	input-multiline	\N	\N	\N	f	f	14	full	\N	Description newsletter	\N	f	\N	\N	\N	t
56	newsletter_subscribers	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
57	newsletter_subscribers	email	\N	input	\N	\N	\N	f	f	2	full	\N	Adresse email	\N	t	\N	\N	\N	t
58	newsletter_subscribers	date_created	date-created	datetime	\N	\N	\N	t	f	3	full	\N	\N	\N	f	\N	\N	\N	t
62	blog_posts	cover_image	file	file-image	{"folder":"636a26fa-1c70-4f9e-a125-100f2af93883","letterbox":true}	\N	\N	f	f	14	full	\N	\N	\N	f	\N	\N	\N	t
63	job_offers	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
64	job_offers	status	\N	select-dropdown	{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
65	job_offers	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N	t
66	job_offers	date_created	date-created	datetime	\N	\N	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
67	job_offers	date_updated	date-updated	datetime	\N	\N	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
68	job_offers	title	\N	input	\N	\N	\N	f	f	6	full	\N	Titre du poste	\N	t	\N	\N	\N	t
69	job_offers	slug	\N	input	\N	\N	\N	f	f	7	half	\N	URL slug	\N	t	\N	\N	\N	t
70	job_offers	department	\N	select-dropdown	{"choices":[{"text":"Ingénierie","value":"Ingénierie"},{"text":"Design","value":"Design"},{"text":"Marketing","value":"Marketing"},{"text":"Ventes","value":"Ventes"},{"text":"Opérations","value":"Opérations"}]}	\N	\N	f	f	8	half	\N	\N	\N	t	\N	\N	\N	t
1	products	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
3	products	sort	\N	input	\N	\N	\N	f	t	3	full	\N	\N	\N	f	\N	\N	\N	t
4	products	date_created	date-created	datetime	\N	\N	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
5	products	date_updated	date-updated	datetime	\N	\N	\N	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
6	products	name	\N	input	\N	\N	\N	f	f	6	half	\N	Nom du produit	\N	t	\N	\N	\N	t
7	products	slug	\N	input	\N	\N	\N	f	f	7	half	\N	URL du produit (ex: dommpay)	\N	t	\N	\N	\N	t
8	products	description	\N	input-multiline	\N	\N	\N	f	f	8	full	\N	Description courte	\N	f	\N	\N	\N	t
9	products	content	\N	input-rich-text-html	\N	\N	\N	f	f	9	full	\N	Contenu détaillé de la page produit	\N	f	\N	\N	\N	t
10	products	icon	\N	input	\N	\N	\N	f	f	11	half	\N	Nom de l icône Lucide (ex: Wallet, Cloud)	\N	f	\N	\N	\N	t
11	products	color	\N	input	\N	\N	\N	f	f	12	half	\N	Couleur CSS (ex: text-emerald-500)	\N	f	\N	\N	\N	t
59	products	features	cast-json	tags	\N	\N	\N	f	f	13	full	\N	Liste de fonctionnalités clés	\N	f	\N	\N	\N	t
71	job_offers	location	\N	input	\N	\N	\N	f	f	9	half	\N	Ex: Cotonou, Bénin / Remote	\N	f	\N	\N	\N	t
72	job_offers	type	\N	select-dropdown	{"choices":[{"text":"CDI","value":"CDI"},{"text":"CDD","value":"CDD"},{"text":"Stage","value":"Stage"},{"text":"Freelance","value":"Freelance"}]}	\N	\N	f	f	10	half	\N	\N	\N	t	\N	\N	\N	t
73	job_offers	description	\N	input-multiline	\N	\N	\N	f	f	11	full	\N	Court résumé (2-3 phrases)	\N	f	\N	\N	\N	t
74	job_offers	content	\N	input-rich-text-html	\N	\N	\N	f	f	12	full	\N	Description complète du poste	\N	f	\N	\N	\N	t
75	job_offers	date_published	\N	datetime	\N	\N	\N	f	f	13	half	\N	\N	\N	f	\N	\N	\N	t
76	applications	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
77	applications	status	\N	select-dropdown	{"choices":[{"text":"Nouveau","value":"new"},{"text":"Examiné","value":"reviewed"},{"text":"Entretien","value":"interview"},{"text":"Accepté","value":"accepted"},{"text":"Refusé","value":"rejected"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
78	applications	date_created	date-created	datetime	\N	\N	\N	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
79	applications	first_name	\N	input	\N	\N	\N	f	f	4	half	\N	Prénom	\N	t	\N	\N	\N	t
80	applications	last_name	\N	input	\N	\N	\N	f	f	5	half	\N	Nom	\N	t	\N	\N	\N	t
81	applications	email	\N	input	\N	\N	\N	f	f	6	half	\N	Email	\N	t	\N	\N	\N	t
82	applications	phone	\N	input	\N	\N	\N	f	f	7	half	\N	Téléphone	\N	f	\N	\N	\N	t
83	applications	country	\N	input	\N	\N	\N	f	f	8	half	\N	Pays	\N	t	\N	\N	\N	t
84	applications	job_title	\N	input	\N	\N	\N	t	f	9	half	\N	Poste visé	\N	f	\N	\N	\N	t
85	applications	job_slug	\N	input	\N	\N	\N	f	t	10	half	\N	\N	\N	f	\N	\N	\N	t
86	applications	motivation	\N	input-multiline	\N	\N	\N	f	f	11	full	\N	Quelques lignes de motivation	\N	f	\N	\N	\N	t
87	applications	cv	file	file	\N	file	\N	f	f	12	full	\N	CV (PDF, DOC, DOCX)	\N	f	\N	\N	\N	t
88	site_settings	legal_mentions	\N	input-rich-text-html	\N	\N	\N	f	f	15	full	\N	Mentions légales	\N	f	\N	\N	\N	t
89	site_settings	privacy_policy	\N	input-rich-text-html	\N	\N	\N	f	f	16	full	\N	Politique de confidentialité	\N	f	\N	\N	\N	t
90	site_settings	terms_of_use	\N	input-rich-text-html	\N	\N	\N	f	f	17	full	\N	Conditions générales d'utilisation	\N	f	\N	\N	\N	t
2	products	status	\N	select-dropdown	{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Bientôt","value":"coming_soon"},{"text":"Archivé","value":"archived"}]}	labels	\N	f	f	2	half	\N	\N	\N	f	\N	\N	\N	t
92	products	featured	cast-boolean	boolean	\N	boolean	\N	f	f	14	full	\N	Afficher sur la homepage	\N	f	\N	\N	\N	t
93	products	url	\N	input	\N	raw	\N	f	f	15	full	\N	URL externe du produit (ex: https://gestiloc.io)	\N	f	\N	\N	\N	t
94	products	category	cast-json	select-multiple-dropdown	{"choices":[{"text":"Entreprise","value":"entreprise"},{"text":"Particulier","value":"particulier"}]}	labels	\N	f	f	16	full	\N	Categorie pour le filtrage sur la homepage	\N	f	\N	\N	\N	t
91	products	image	file	file-image	{"crop":false}	image	\N	f	f	10	full	[{"language":"en-US","translation":"Logo"},{"language":"fr-FR","translation":"Logo"}]	Logo de la solution	\N	f	\N	\N	\N	t
96	stats	id	uuid	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
97	stats	sort	\N	input	\N	\N	\N	f	t	2	half	\N	\N	\N	f	\N	\N	\N	t
98	stats	status	\N	select-dropdown	{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"}]}	labels	\N	f	f	3	half	\N	\N	\N	f	\N	\N	\N	t
99	stats	value	\N	input	\N	\N	\N	f	f	4	half	\N	Le chiffre (ex: 1, 15, 100)	\N	t	\N	\N	\N	t
100	stats	suffix	\N	input	\N	\N	\N	f	f	5	half	\N	Texte apres le chiffre (ex: +, %, K)	\N	f	\N	\N	\N	t
101	stats	label	\N	input	\N	\N	\N	f	f	6	full	\N	Description sous le chiffre (ex: Utilisateurs)	\N	t	\N	\N	\N	t
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
55a318cc-ae6b-48a6-9865-3bbc83f20982	local	55a318cc-ae6b-48a6-9865-3bbc83f20982.png	Capture d’écran 2026-02-02 à 09.23.42 (2).png	Capture D’écran 2026 02 02 À 09.23.42 (2)	image/png	636a26fa-1c70-4f9e-a125-100f2af93883	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 18:02:46.554+00	\N	2026-02-04 18:02:46.815+00	\N	3352436	1920	1080	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-02-04 18:02:46.814+00
79ce463c-8e10-4735-86d8-f1e159c5cbd0	local	79ce463c-8e10-4735-86d8-f1e159c5cbd0.docx	DevBoost_Guide_Complet_V2.docx	Dev Boost Guide Complet V2	application/vnd.openxmlformats-officedocument.wordprocessingml.document	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 20:32:18.523+00	\N	2026-02-04 20:32:18.743+00	\N	904741	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2026-02-04 20:32:18.74+00
2a43a3f1-63dd-41f1-8042-d63451eaad23	local	2a43a3f1-63dd-41f1-8042-d63451eaad23.png	Capture d’écran 2026-02-04 à 23.26.13.png	Capture D’écran 2026 02 04 À 23.26.13	image/png	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:04.432+00	\N	2026-02-04 22:36:04.624+00	\N	1163511	2880	1800	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-02-04 22:36:04.622+00
752de803-5294-4947-930b-5dc379152447	local	752de803-5294-4947-930b-5dc379152447.png	Capture d’écran 2026-01-08 à 00.05.44.png	Capture D’écran 2026 01 08 À 00.05.44	image/png	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-04 22:36:27.842+00	\N	2026-02-04 22:36:27.879+00	\N	792093	2880	1800	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-02-04 22:36:27.878+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	Notification Nouveau Contact	mail	#2c85c5	Envoie un email à l admin quand un nouveau message de contact est reçu	active	event	all	{"type":"action","scope":["items.create"],"collections":["contacts"]}	54dced3b-2149-4e47-9470-9d43058ad9dd	2026-02-05 16:00:33.043+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
47382480-b09f-4b82-bc6d-ba32ae593bc7	Bienvenue Newsletter	celebration	#10b981	Envoie un email de bienvenue aux nouveaux abonnés newsletter	active	event	all	{"type":"action","scope":["items.create"],"collections":["newsletter_subscribers"]}	1da568e1-d35b-4424-8d0b-7a336e99bb06	2026-02-05 16:01:12.787+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
d1eb8f40-8120-4a24-8752-ac80817255a3	Notification Nouvelle Candidature	assignment_ind	#8b5cf6	Notifie l'admin quand une nouvelle candidature est recue	active	event	all	{"type":"action","scope":["items.create"],"collections":["applications"]}	ea77d55b-08c4-4213-abda-0e07d4cdef1c	2026-02-05 16:02:00.698+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
012fcd04-b4e2-482b-afdd-ec39ea068e89	Accepter la candidature	check_circle	#22c55e	Bouton pour accepter une candidature et notifier le candidat par email	active	manual	all	{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous accepter cette candidature ? Un email sera envoyé au candidat."}	3020d7db-904d-4d59-b756-e8194e509185	2026-02-06 09:15:55.274+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
ebd58ddf-7b37-446e-ada8-5fb0866902da	Refuser la candidature	cancel	#ef4444	Bouton pour refuser une candidature et notifier le candidat par email	active	manual	all	{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous refuser cette candidature ? Un email sera envoyé au candidat."}	fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92	2026-02-06 09:15:55.478+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
636a26fa-1c70-4f9e-a125-100f2af93883	blog	\N
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2026-02-04 16:58:00.212703+00
20201029A	Remove System Relations	2026-02-04 16:58:00.218266+00
20201029B	Remove System Collections	2026-02-04 16:58:00.22185+00
20201029C	Remove System Fields	2026-02-04 16:58:00.230118+00
20201105A	Add Cascade System Relations	2026-02-04 16:58:00.250259+00
20201105B	Change Webhook URL Type	2026-02-04 16:58:00.254755+00
20210225A	Add Relations Sort Field	2026-02-04 16:58:00.258971+00
20210304A	Remove Locked Fields	2026-02-04 16:58:00.260874+00
20210312A	Webhooks Collections Text	2026-02-04 16:58:00.265526+00
20210331A	Add Refresh Interval	2026-02-04 16:58:00.266848+00
20210415A	Make Filesize Nullable	2026-02-04 16:58:00.270148+00
20210416A	Add Collections Accountability	2026-02-04 16:58:00.272177+00
20210422A	Remove Files Interface	2026-02-04 16:58:00.273399+00
20210506A	Rename Interfaces	2026-02-04 16:58:00.290864+00
20210510A	Restructure Relations	2026-02-04 16:58:00.301174+00
20210518A	Add Foreign Key Constraints	2026-02-04 16:58:00.306128+00
20210519A	Add System Fk Triggers	2026-02-04 16:58:00.319815+00
20210521A	Add Collections Icon Color	2026-02-04 16:58:00.32199+00
20210525A	Add Insights	2026-02-04 16:58:00.334037+00
20210608A	Add Deep Clone Config	2026-02-04 16:58:00.33945+00
20210626A	Change Filesize Bigint	2026-02-04 16:58:00.371785+00
20210716A	Add Conditions to Fields	2026-02-04 16:58:00.375398+00
20210721A	Add Default Folder	2026-02-04 16:58:00.386208+00
20210802A	Replace Groups	2026-02-04 16:58:00.390989+00
20210803A	Add Required to Fields	2026-02-04 16:58:00.392496+00
20210805A	Update Groups	2026-02-04 16:58:00.399821+00
20210805B	Change Image Metadata Structure	2026-02-04 16:58:00.408319+00
20210811A	Add Geometry Config	2026-02-04 16:58:00.42292+00
20210831A	Remove Limit Column	2026-02-04 16:58:00.451499+00
20210903A	Add Auth Provider	2026-02-04 16:58:00.551192+00
20210907A	Webhooks Collections Not Null	2026-02-04 16:58:00.559176+00
20210910A	Move Module Setup	2026-02-04 16:58:00.563916+00
20210920A	Webhooks URL Not Null	2026-02-04 16:58:00.581386+00
20210924A	Add Collection Organization	2026-02-04 16:58:00.587933+00
20210927A	Replace Fields Group	2026-02-04 16:58:00.617637+00
20210927B	Replace M2M Interface	2026-02-04 16:58:00.634425+00
20210929A	Rename Login Action	2026-02-04 16:58:00.648615+00
20211007A	Update Presets	2026-02-04 16:58:00.700495+00
20211009A	Add Auth Data	2026-02-04 16:58:00.707306+00
20211016A	Add Webhook Headers	2026-02-04 16:58:00.718437+00
20211103A	Set Unique to User Token	2026-02-04 16:58:00.741594+00
20211103B	Update Special Geometry	2026-02-04 16:58:00.755302+00
20211104A	Remove Collections Listing	2026-02-04 16:58:00.761808+00
20211118A	Add Notifications	2026-02-04 16:58:00.790369+00
20211211A	Add Shares	2026-02-04 16:58:00.815915+00
20211230A	Add Project Descriptor	2026-02-04 16:58:00.820562+00
20220303A	Remove Default Project Color	2026-02-04 16:58:00.832288+00
20220308A	Add Bookmark Icon and Color	2026-02-04 16:58:00.842216+00
20220314A	Add Translation Strings	2026-02-04 16:58:00.849122+00
20220322A	Rename Field Typecast Flags	2026-02-04 16:58:00.873302+00
20220323A	Add Field Validation	2026-02-04 16:58:00.881599+00
20220325A	Fix Typecast Flags	2026-02-04 16:58:00.889512+00
20220325B	Add Default Language	2026-02-04 16:58:00.901352+00
20220402A	Remove Default Value Panel Icon	2026-02-04 16:58:00.905402+00
20220429A	Add Flows	2026-02-04 16:58:00.966699+00
20220429B	Add Color to Insights Icon	2026-02-04 16:58:00.970186+00
20220429C	Drop Non Null From IP of Activity	2026-02-04 16:58:00.973152+00
20220429D	Drop Non Null From Sender of Notifications	2026-02-04 16:58:00.97449+00
20220614A	Rename Hook Trigger to Event	2026-02-04 16:58:00.975803+00
20220801A	Update Notifications Timestamp Column	2026-02-04 16:58:01.004196+00
20220802A	Add Custom Aspect Ratios	2026-02-04 16:58:01.016623+00
20220826A	Add Origin to Accountability	2026-02-04 16:58:01.020587+00
20230401A	Update Material Icons	2026-02-04 16:58:01.034477+00
20230525A	Add Preview Settings	2026-02-04 16:58:01.036704+00
20230526A	Migrate Translation Strings	2026-02-04 16:58:01.064733+00
20230721A	Require Shares Fields	2026-02-04 16:58:01.073314+00
20230823A	Add Content Versioning	2026-02-04 16:58:01.132644+00
20230927A	Themes	2026-02-04 16:58:01.167388+00
20231009A	Update CSV Fields to Text	2026-02-04 16:58:01.172476+00
20231009B	Update Panel Options	2026-02-04 16:58:01.174205+00
20231010A	Add Extensions	2026-02-04 16:58:01.179442+00
20231215A	Add Focalpoints	2026-02-04 16:58:01.181872+00
20240122A	Add Report URL Fields	2026-02-04 16:58:01.183455+00
20240204A	Marketplace	2026-02-04 16:58:01.213901+00
20240305A	Change Useragent Type	2026-02-04 16:58:01.221943+00
20240311A	Deprecate Webhooks	2026-02-04 16:58:01.233626+00
20240422A	Public Registration	2026-02-04 16:58:01.239312+00
20240515A	Add Session Window	2026-02-04 16:58:01.240936+00
20240701A	Add Tus Data	2026-02-04 16:58:01.242486+00
20240716A	Update Files Date Fields	2026-02-04 16:58:01.248459+00
20240806A	Permissions Policies	2026-02-04 16:58:01.279194+00
20240817A	Update Icon Fields Length	2026-02-04 16:58:01.299451+00
20240909A	Separate Comments	2026-02-04 16:58:01.311816+00
20240909B	Consolidate Content Versioning	2026-02-04 16:58:01.31393+00
20240924A	Migrate Legacy Comments	2026-02-04 16:58:01.317083+00
20240924B	Populate Versioning Deltas	2026-02-04 16:58:01.320595+00
20250224A	Visual Editor	2026-02-04 16:58:01.323043+00
20250609A	License Banner	2026-02-04 16:58:01.329491+00
20250613A	Add Project ID	2026-02-04 16:58:01.339833+00
20250718A	Add Direction	2026-02-04 16:58:01.34425+00
20250813A	Add MCP	2026-02-04 16:58:01.349541+00
20251012A	Add Field Searchable	2026-02-04 16:58:01.352031+00
20251014A	Add Project Owner	2026-02-04 16:58:01.399791+00
20251028A	Add Retention Indexes	2026-02-04 16:58:01.667488+00
20251103A	Add AI Settings	2026-02-04 16:58:01.672192+00
20251224A	Remove Webhooks	2026-02-04 16:58:01.682068+00
20260113A	Add Revisions Index	2026-02-04 16:58:01.733283+00
20260110A	Add AI Provider Settings	2026-02-22 15:35:00.265359+00
20260128A	Add Collaborative Editing	2026-02-22 15:35:00.270478+00
20260204A	Add Deployment	2026-02-22 15:35:00.296755+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
54dced3b-2149-4e47-9470-9d43058ad9dd	Envoyer Email Admin	send_email_admin	mail	19	1	{"to":"minhadjenontin@gmail.com","subject":"🔔 Nouveau message de contact - DOMMSOFT","body":"<h2>Nouveau message reçu</h2><p><strong>De:</strong> {{$trigger.payload.name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Sujet:</strong> {{$trigger.payload.subject}}</p><p><strong>Message:</strong></p><p>{{$trigger.payload.message}}</p><hr><p><small>Reçu le {{$trigger.payload.date_created}}</small></p>","type":"text/html"}	\N	\N	3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	2026-02-05 16:00:43.084+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
1da568e1-d35b-4424-8d0b-7a336e99bb06	Email Bienvenue	welcome_email	mail	19	1	{"to":"{{$trigger.payload.email}}","subject":"Bienvenue dans la newsletter DOMMSOFT!","body":"<h1>Bienvenue chez DOMMSOFT!</h1><p>Merci pour votre inscription.</p><p>L'equipe DOMMSOFT</p>","type":"text/html"}	\N	\N	47382480-b09f-4b82-bc6d-ba32ae593bc7	2026-02-05 16:01:48.638+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
ea77d55b-08c4-4213-abda-0e07d4cdef1c	Notifier Admin Candidature	notify_application	mail	19	1	{"to":"minhadjenontin@gmail.com","subject":"Nouvelle candidature recue - DOMMSOFT","body":"<h2>Nouvelle candidature!</h2><p><strong>Candidat:</strong> {{$trigger.payload.first_name}} {{$trigger.payload.last_name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Poste:</strong> {{$trigger.payload.position}}</p><p>Connectez-vous a Directus pour voir le CV et les details.</p>","type":"text/html"}	\N	\N	d1eb8f40-8120-4a24-8752-ac80817255a3	2026-02-05 16:02:00.746+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f	Envoyer email acceptation	send_accepted_email	mail	37	1	{"to":["{{read_candidature.email}}"],"subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_candidature.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_candidature.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"}	\N	\N	012fcd04-b4e2-482b-afdd-ec39ea068e89	2026-02-06 09:15:55.305+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa	Marquer comme acceptée	update_status_accepted	item-update	28	1	{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"accepted"}}	a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f	\N	012fcd04-b4e2-482b-afdd-ec39ea068e89	2026-02-06 09:15:55.324+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
3020d7db-904d-4d59-b756-e8194e509185	Lire la candidature	read_candidature	item-read	19	1	{"collection":"applications","key":"{{$trigger.body[0]}}"}	d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa	\N	012fcd04-b4e2-482b-afdd-ec39ea068e89	2026-02-06 09:15:55.368+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a	Envoyer email refus	send_refused_email	mail	37	1	{"to":["{{read_candidature_refus.email}}"],"subject":"Suite à votre candidature chez DOMMSOFT","body":"<h2>Bonjour {{read_candidature_refus.first_name}},</h2><p>Nous vous remercions pour l'intérêt que vous portez à DOMMSOFT et pour le temps consacré à votre candidature pour le poste <strong>\\"{{read_candidature_refus.job_title}}\\"</strong>.</p><p>Après étude attentive de votre dossier, nous avons le regret de vous informer que votre candidature n'a pas été retenue pour ce poste.</p><p>Nous conservons votre profil et ne manquerons pas de vous recontacter si une opportunité correspondant à votre profil se présente.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"}	\N	\N	ebd58ddf-7b37-446e-ada8-5fb0866902da	2026-02-06 09:15:55.498+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
b3b957d3-1529-4c1b-aa52-a84fd489e964	Marquer comme refusée	update_status_refused	item-update	28	1	{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"refused"}}	b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a	\N	ebd58ddf-7b37-446e-ada8-5fb0866902da	2026-02-06 09:15:55.51+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92	Lire la candidature	read_candidature_refus	item-read	19	1	{"collection":"applications","key":"{{$trigger.body[0]}}"}	b3b957d3-1529-4c1b-aa52-a84fd489e964	\N	ebd58ddf-7b37-446e-ada8-5fb0866902da	2026-02-06 09:15:55.531+00	c0731d51-a5b8-49a9-901f-d0de152a48e6
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, collection, action, permissions, validation, presets, fields, policy) FROM stdin;
1	products	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
2	blog_posts	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
3	testimonials	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
4	site_settings	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
5	contacts	create	\N	\N	\N	name,email,subject,message	abf8a154-5b1c-4a46-ac9c-7300570f4f17
6	directus_files	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
7	newsletter_subscribers	create	\N	\N	\N	email	abf8a154-5b1c-4a46-ac9c-7300570f4f17
8	job_offers	read	\N	\N	\N	*	abf8a154-5b1c-4a46-ac9c-7300570f4f17
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
cee9e31d-bed2-495d-88c8-07deb57e052d	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
4	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	testimonials	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
2	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	products	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
5	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
8	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	job_offers	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
1	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	contacts	\N	\N	{"tabular":{"page":1,"fields":["date_created","email","name","status","message"]}}	\N	\N	\N	bookmark	\N
6	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	newsletter_subscribers	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
7	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	applications	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
3	\N	c0731d51-a5b8-49a9-901f-d0de152a48e6	\N	blog_posts	\N	\N	{"tabular":{"page":1}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
2	blog_posts	cover_image	directus_files	\N	\N	\N	\N	\N	nullify
3	applications	cv	directus_files	\N	\N	\N	\N	\N	nullify
4	products	image	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	2	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null}	\N	\N
2	4	directus_fields	1	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"products"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"products"}	\N	\N
3	5	directus_fields	2	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Bientôt","value":"coming_soon"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"products"}	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Bientôt","value":"coming_soon"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"products"}	\N	\N
4	6	directus_fields	3	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"products"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"products"}	\N	\N
5	7	directus_fields	4	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"products"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"products"}	\N	\N
6	8	directus_fields	5	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"products"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"products"}	\N	\N
7	9	directus_fields	6	{"sort":6,"interface":"input","required":true,"width":"half","note":"Nom du produit","field":"name","collection":"products"}	{"sort":6,"interface":"input","required":true,"width":"half","note":"Nom du produit","field":"name","collection":"products"}	\N	\N
8	10	directus_fields	7	{"sort":7,"interface":"input","required":true,"width":"half","note":"URL du produit (ex: dommpay)","field":"slug","collection":"products"}	{"sort":7,"interface":"input","required":true,"width":"half","note":"URL du produit (ex: dommpay)","field":"slug","collection":"products"}	\N	\N
9	11	directus_fields	8	{"sort":8,"interface":"input-multiline","note":"Description courte","field":"description","collection":"products"}	{"sort":8,"interface":"input-multiline","note":"Description courte","field":"description","collection":"products"}	\N	\N
10	12	directus_fields	9	{"sort":9,"interface":"input-rich-text-html","note":"Contenu détaillé de la page produit","field":"content","collection":"products"}	{"sort":9,"interface":"input-rich-text-html","note":"Contenu détaillé de la page produit","field":"content","collection":"products"}	\N	\N
11	13	directus_fields	10	{"sort":10,"interface":"input","width":"half","note":"Nom de l icône Lucide (ex: Wallet, Cloud)","field":"icon","collection":"products"}	{"sort":10,"interface":"input","width":"half","note":"Nom de l icône Lucide (ex: Wallet, Cloud)","field":"icon","collection":"products"}	\N	\N
12	14	directus_fields	11	{"sort":11,"interface":"input","width":"half","note":"Couleur CSS (ex: text-emerald-500)","field":"color","collection":"products"}	{"sort":11,"interface":"input","width":"half","note":"Couleur CSS (ex: text-emerald-500)","field":"color","collection":"products"}	\N	\N
13	15	directus_fields	12	{"sort":12,"interface":"file-image","special":["file"],"note":"Image/screenshot du produit","field":"image","collection":"products"}	{"sort":12,"interface":"file-image","special":["file"],"note":"Image/screenshot du produit","field":"image","collection":"products"}	\N	\N
14	16	directus_collections	products	{"collection":"products","icon":"inventory_2","note":"Produits et réalisations DOMMSOFT","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	{"collection":"products","icon":"inventory_2","note":"Produits et réalisations DOMMSOFT","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	\N	\N
15	18	directus_fields	13	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"blog_posts"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"blog_posts"}	\N	\N
16	19	directus_fields	14	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"blog_posts"}	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"blog_posts"}	\N	\N
17	20	directus_fields	15	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"blog_posts"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"blog_posts"}	\N	\N
18	21	directus_fields	16	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"blog_posts"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"blog_posts"}	\N	\N
19	22	directus_fields	17	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"blog_posts"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"blog_posts"}	\N	\N
20	23	directus_fields	18	{"sort":6,"interface":"input","required":true,"note":"Titre de l article","field":"title","collection":"blog_posts"}	{"sort":6,"interface":"input","required":true,"note":"Titre de l article","field":"title","collection":"blog_posts"}	\N	\N
21	24	directus_fields	19	{"sort":7,"interface":"input","required":true,"width":"half","note":"URL de l article","field":"slug","collection":"blog_posts"}	{"sort":7,"interface":"input","required":true,"width":"half","note":"URL de l article","field":"slug","collection":"blog_posts"}	\N	\N
22	25	directus_fields	20	{"sort":8,"interface":"input-multiline","note":"Résumé court affiché dans les listes","field":"excerpt","collection":"blog_posts"}	{"sort":8,"interface":"input-multiline","note":"Résumé court affiché dans les listes","field":"excerpt","collection":"blog_posts"}	\N	\N
23	26	directus_fields	21	{"sort":9,"interface":"input-rich-text-html","note":"Contenu complet de l article","field":"content","collection":"blog_posts"}	{"sort":9,"interface":"input-rich-text-html","note":"Contenu complet de l article","field":"content","collection":"blog_posts"}	\N	\N
24	27	directus_fields	22	{"sort":10,"interface":"file-image","special":["file"],"note":"Image de couverture","field":"cover_image","collection":"blog_posts"}	{"sort":10,"interface":"file-image","special":["file"],"note":"Image de couverture","field":"cover_image","collection":"blog_posts"}	\N	\N
25	28	directus_fields	23	{"sort":11,"interface":"datetime","width":"half","note":"Date de publication","field":"date_published","collection":"blog_posts"}	{"sort":11,"interface":"datetime","width":"half","note":"Date de publication","field":"date_published","collection":"blog_posts"}	\N	\N
26	29	directus_fields	24	{"sort":12,"interface":"input","width":"half","note":"Nom de l auteur","field":"author","collection":"blog_posts"}	{"sort":12,"interface":"input","width":"half","note":"Nom de l auteur","field":"author","collection":"blog_posts"}	\N	\N
27	30	directus_fields	25	{"sort":13,"interface":"tags","special":["cast-json"],"note":"Tags de l article","field":"tags","collection":"blog_posts"}	{"sort":13,"interface":"tags","special":["cast-json"],"note":"Tags de l article","field":"tags","collection":"blog_posts"}	\N	\N
28	31	directus_collections	blog_posts	{"collection":"blog_posts","icon":"article","note":"Articles de blog et actualités","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	{"collection":"blog_posts","icon":"article","note":"Articles de blog et actualités","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	\N	\N
29	33	directus_fields	26	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"contacts"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"contacts"}	\N	\N
30	34	directus_fields	27	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Nouveau","value":"new"},{"text":"Lu","value":"read"},{"text":"Répondu","value":"replied"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"new","field":"status","collection":"contacts"}	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Nouveau","value":"new"},{"text":"Lu","value":"read"},{"text":"Répondu","value":"replied"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"new","field":"status","collection":"contacts"}	\N	\N
31	35	directus_fields	28	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"width":"half","field":"date_created","collection":"contacts"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"width":"half","field":"date_created","collection":"contacts"}	\N	\N
32	36	directus_fields	29	{"sort":4,"interface":"input","required":true,"width":"half","note":"Nom complet","field":"name","collection":"contacts"}	{"sort":4,"interface":"input","required":true,"width":"half","note":"Nom complet","field":"name","collection":"contacts"}	\N	\N
33	37	directus_fields	30	{"sort":5,"interface":"input","required":true,"width":"half","note":"Adresse email","field":"email","collection":"contacts"}	{"sort":5,"interface":"input","required":true,"width":"half","note":"Adresse email","field":"email","collection":"contacts"}	\N	\N
34	38	directus_fields	31	{"sort":6,"interface":"input","note":"Sujet du message","field":"subject","collection":"contacts"}	{"sort":6,"interface":"input","note":"Sujet du message","field":"subject","collection":"contacts"}	\N	\N
35	39	directus_fields	32	{"sort":7,"interface":"input-multiline","required":true,"note":"Contenu du message","field":"message","collection":"contacts"}	{"sort":7,"interface":"input-multiline","required":true,"note":"Contenu du message","field":"message","collection":"contacts"}	\N	\N
36	40	directus_fields	33	{"sort":8,"interface":"input-multiline","note":"Notes internes (réponse, suivi...)","field":"notes","collection":"contacts"}	{"sort":8,"interface":"input-multiline","note":"Notes internes (réponse, suivi...)","field":"notes","collection":"contacts"}	\N	\N
37	41	directus_collections	contacts	{"collection":"contacts","icon":"mail","note":"Messages reçus via le formulaire de contact","archive_field":"status","archive_value":"archived","unarchive_value":"new"}	{"collection":"contacts","icon":"mail","note":"Messages reçus via le formulaire de contact","archive_field":"status","archive_value":"archived","unarchive_value":"new"}	\N	\N
38	43	directus_fields	34	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"testimonials"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"testimonials"}	\N	\N
39	44	directus_fields	35	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"testimonials"}	{"sort":2,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Archivé","value":"archived"}]},"display":"labels","width":"half","default_value":"draft","field":"status","collection":"testimonials"}	\N	\N
40	45	directus_fields	36	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"testimonials"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"testimonials"}	\N	\N
41	46	directus_fields	37	{"sort":4,"interface":"input-multiline","required":true,"note":"Citation du client","field":"quote","collection":"testimonials"}	{"sort":4,"interface":"input-multiline","required":true,"note":"Citation du client","field":"quote","collection":"testimonials"}	\N	\N
42	47	directus_fields	38	{"sort":5,"interface":"input","required":true,"width":"half","note":"Nom du client","field":"name","collection":"testimonials"}	{"sort":5,"interface":"input","required":true,"width":"half","note":"Nom du client","field":"name","collection":"testimonials"}	\N	\N
43	48	directus_fields	39	{"sort":6,"interface":"input","width":"half","note":"Poste occupé","field":"role","collection":"testimonials"}	{"sort":6,"interface":"input","width":"half","note":"Poste occupé","field":"role","collection":"testimonials"}	\N	\N
44	49	directus_fields	40	{"sort":7,"interface":"input","width":"half","note":"Entreprise","field":"company","collection":"testimonials"}	{"sort":7,"interface":"input","width":"half","note":"Entreprise","field":"company","collection":"testimonials"}	\N	\N
45	50	directus_fields	41	{"sort":8,"interface":"file-image","special":["file"],"width":"half","note":"Photo du client","field":"avatar","collection":"testimonials"}	{"sort":8,"interface":"file-image","special":["file"],"width":"half","note":"Photo du client","field":"avatar","collection":"testimonials"}	\N	\N
46	51	directus_collections	testimonials	{"collection":"testimonials","icon":"format_quote","note":"Témoignages clients","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	{"collection":"testimonials","icon":"format_quote","note":"Témoignages clients","sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"published"}	\N	\N
47	52	directus_fields	42	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"site_settings"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"site_settings"}	\N	\N
48	53	directus_fields	43	{"sort":2,"interface":"input","note":"Titre principal du Hero","width":"full","field":"hero_title","collection":"site_settings"}	{"sort":2,"interface":"input","note":"Titre principal du Hero","width":"full","field":"hero_title","collection":"site_settings"}	\N	\N
49	54	directus_fields	44	{"sort":3,"interface":"input","note":"Sous-titre du Hero","width":"full","field":"hero_subtitle","collection":"site_settings"}	{"sort":3,"interface":"input","note":"Sous-titre du Hero","width":"full","field":"hero_subtitle","collection":"site_settings"}	\N	\N
50	55	directus_fields	45	{"sort":4,"interface":"input-multiline","note":"Description sous le titre","field":"hero_description","collection":"site_settings"}	{"sort":4,"interface":"input-multiline","note":"Description sous le titre","field":"hero_description","collection":"site_settings"}	\N	\N
51	56	directus_fields	46	{"sort":5,"interface":"input","note":"Texte du badge (ex: L innovation au service de tous)","width":"full","field":"hero_badge","collection":"site_settings"}	{"sort":5,"interface":"input","note":"Texte du badge (ex: L innovation au service de tous)","width":"full","field":"hero_badge","collection":"site_settings"}	\N	\N
52	57	directus_fields	47	{"sort":6,"interface":"input","width":"half","note":"Texte du bouton principal","field":"cta_primary_text","collection":"site_settings"}	{"sort":6,"interface":"input","width":"half","note":"Texte du bouton principal","field":"cta_primary_text","collection":"site_settings"}	\N	\N
53	58	directus_fields	48	{"sort":7,"interface":"input","width":"half","note":"Lien du bouton principal","field":"cta_primary_url","collection":"site_settings"}	{"sort":7,"interface":"input","width":"half","note":"Lien du bouton principal","field":"cta_primary_url","collection":"site_settings"}	\N	\N
54	59	directus_fields	49	{"sort":8,"interface":"input","width":"half","note":"Texte du bouton secondaire","field":"cta_secondary_text","collection":"site_settings"}	{"sort":8,"interface":"input","width":"half","note":"Texte du bouton secondaire","field":"cta_secondary_text","collection":"site_settings"}	\N	\N
55	60	directus_fields	50	{"sort":9,"interface":"input","width":"half","note":"Lien du bouton secondaire","field":"cta_secondary_url","collection":"site_settings"}	{"sort":9,"interface":"input","width":"half","note":"Lien du bouton secondaire","field":"cta_secondary_url","collection":"site_settings"}	\N	\N
56	61	directus_fields	51	{"sort":10,"interface":"input","width":"half","note":"Lien Twitter/X","field":"social_twitter","collection":"site_settings"}	{"sort":10,"interface":"input","width":"half","note":"Lien Twitter/X","field":"social_twitter","collection":"site_settings"}	\N	\N
57	62	directus_fields	52	{"sort":11,"interface":"input","width":"half","note":"Lien LinkedIn","field":"social_linkedin","collection":"site_settings"}	{"sort":11,"interface":"input","width":"half","note":"Lien LinkedIn","field":"social_linkedin","collection":"site_settings"}	\N	\N
58	63	directus_fields	53	{"sort":12,"interface":"input","width":"half","note":"Lien GitHub","field":"social_github","collection":"site_settings"}	{"sort":12,"interface":"input","width":"half","note":"Lien GitHub","field":"social_github","collection":"site_settings"}	\N	\N
59	64	directus_fields	54	{"sort":13,"interface":"input","note":"Titre de la section newsletter","field":"footer_newsletter_title","collection":"site_settings"}	{"sort":13,"interface":"input","note":"Titre de la section newsletter","field":"footer_newsletter_title","collection":"site_settings"}	\N	\N
60	65	directus_fields	55	{"sort":14,"interface":"input-multiline","note":"Description newsletter","field":"footer_newsletter_description","collection":"site_settings"}	{"sort":14,"interface":"input-multiline","note":"Description newsletter","field":"footer_newsletter_description","collection":"site_settings"}	\N	\N
61	66	directus_collections	site_settings	{"collection":"site_settings","icon":"settings","note":"Paramètres globaux du site","singleton":true}	{"collection":"site_settings","icon":"settings","note":"Paramètres globaux du site","singleton":true}	\N	\N
62	72	directus_permissions	1	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"products","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"products","action":"read","fields":["*"]}	\N	\N
63	73	directus_permissions	2	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"blog_posts","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"blog_posts","action":"read","fields":["*"]}	\N	\N
64	74	directus_permissions	3	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"testimonials","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"testimonials","action":"read","fields":["*"]}	\N	\N
65	75	directus_permissions	4	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"site_settings","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"site_settings","action":"read","fields":["*"]}	\N	\N
66	76	directus_permissions	5	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"contacts","action":"create","fields":["name","email","subject","message"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"contacts","action":"create","fields":["name","email","subject","message"]}	\N	\N
67	77	directus_permissions	6	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"directus_files","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"directus_files","action":"read","fields":["*"]}	\N	\N
68	78	contacts	3f2ecdb6-3444-4362-b440-0712e71c0904	{"name":"Test User","email":"test@test.com","subject":"Test","message":"Ceci est un test"}	{"name":"Test User","email":"test@test.com","subject":"Test","message":"Ceci est un test"}	\N	\N
69	79	contacts	1acbbeb6-b6dd-4b0a-adee-7b6d362c8e82	{"name":"Test User","email":"test@test.com","subject":"Test","message":"Ceci est un test"}	{"name":"Test User","email":"test@test.com","subject":"Test","message":"Ceci est un test"}	\N	\N
70	82	products	2a2fbf26-930b-42ec-881d-49ed6327e6f9	{"name":"DommPay","slug":"dommpay","description":"Solution de paiement unifiée et multi-devise. Acceptez et envoyez des paiements partout.","icon":"Wallet","color":"text-emerald-500","status":"published","sort":1}	{"name":"DommPay","slug":"dommpay","description":"Solution de paiement unifiée et multi-devise. Acceptez et envoyez des paiements partout.","icon":"Wallet","color":"text-emerald-500","status":"published","sort":1}	\N	\N
71	83	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","icon":"Cloud","color":"text-blue-500","status":"published","sort":2}	{"name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","icon":"Cloud","color":"text-blue-500","status":"published","sort":2}	\N	\N
72	84	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","icon":"Users","color":"text-violet-500","status":"published","sort":3}	{"name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","icon":"Users","color":"text-violet-500","status":"published","sort":3}	\N	\N
73	85	products	446bd54e-a33c-4fc3-8e02-589b4dbf9979	{"name":"DommShop","slug":"dommshop","description":"Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.","icon":"ShoppingBag","color":"text-orange-500","status":"published","sort":4}	{"name":"DommShop","slug":"dommshop","description":"Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.","icon":"ShoppingBag","color":"text-orange-500","status":"published","sort":4}	\N	\N
74	87	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	{"hero_badge":"L'innovation au service de tous","hero_title":"Nous imaginons le numérique de demain.","hero_subtitle":"Pensé pour tous.","hero_description":"DOMMSOFT combine savoir-faire technique et créativité pour concevoir des produits numériques qui répondent à de vrais besoins.","cta_primary_text":"Découvrir nos solutions","cta_primary_url":"#products","cta_secondary_text":"Donnez vie à votre idée","cta_secondary_url":"/contact","social_twitter":"https://twitter.com/dommsoft","social_linkedin":"https://linkedin.com/company/dommsoft","social_github":"https://github.com/dommsoft","footer_newsletter_title":"Restez informé de nos nouveautés","footer_newsletter_description":"Recevez nos actualités produits, guides techniques et invitations événementielles directement dans votre boîte mail."}	{"hero_badge":"L'innovation au service de tous","hero_title":"Nous imaginons le numérique de demain.","hero_subtitle":"Pensé pour tous.","hero_description":"DOMMSOFT combine savoir-faire technique et créativité pour concevoir des produits numériques qui répondent à de vrais besoins.","cta_primary_text":"Découvrir nos solutions","cta_primary_url":"#products","cta_secondary_text":"Donnez vie à votre idée","cta_secondary_url":"/contact","social_twitter":"https://twitter.com/dommsoft","social_linkedin":"https://linkedin.com/company/dommsoft","social_github":"https://github.com/dommsoft","footer_newsletter_title":"Restez informé de nos nouveautés","footer_newsletter_description":"Recevez nos actualités produits, guides techniques et invitations événementielles directement dans votre boîte mail."}	\N	\N
75	88	contacts	535d737b-23d1-40fd-9f20-e927fc4d22d6	{"name":"Okalaon Marius Djenontin","email":"minhadjenotinmarius@gmail.com","subject":"ffdsfsdfsdf","message":"dsfdsfdsfdsfdsfsd"}	{"name":"Okalaon Marius Djenontin","email":"minhadjenotinmarius@gmail.com","subject":"ffdsfsdfsdf","message":"dsfdsfdsfdsfdsfsd"}	\N	\N
76	90	contacts	76129039-ac72-452d-a225-fa2c1b2f4b46	{"name":"Okalaon Marius Djenontin","email":"minhadjenotinmarius@gmail.com","subject":"ffdsfsdfsdf","message":"sqSQsqSqs"}	{"name":"Okalaon Marius Djenontin","email":"minhadjenotinmarius@gmail.com","subject":"ffdsfsdfsdf","message":"sqSQsqSqs"}	\N	\N
77	92	directus_fields	56	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"newsletter_subscribers"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"newsletter_subscribers"}	\N	\N
78	93	directus_fields	57	{"sort":2,"interface":"input","required":true,"note":"Adresse email","field":"email","collection":"newsletter_subscribers"}	{"sort":2,"interface":"input","required":true,"note":"Adresse email","field":"email","collection":"newsletter_subscribers"}	\N	\N
79	94	directus_fields	58	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"field":"date_created","collection":"newsletter_subscribers"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"field":"date_created","collection":"newsletter_subscribers"}	\N	\N
80	95	directus_collections	newsletter_subscribers	{"collection":"newsletter_subscribers","icon":"mail","note":"Abonnés à la newsletter"}	{"collection":"newsletter_subscribers","icon":"mail","note":"Abonnés à la newsletter"}	\N	\N
81	96	directus_permissions	7	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"newsletter_subscribers","action":"create","fields":["email"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"newsletter_subscribers","action":"create","fields":["email"]}	\N	\N
82	97	directus_fields	59	{"sort":13,"interface":"tags","special":["cast-json"],"note":"Liste de fonctionnalités clés","collection":"products","field":"features"}	{"sort":13,"interface":"tags","special":["cast-json"],"note":"Liste de fonctionnalités clés","collection":"products","field":"features"}	\N	\N
83	101	products	2b2969f9-a2d2-453e-adb6-53e6236b18f7	{"name":"DommShop","slug":"dommshop","description":"Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.","icon":"ShoppingBag","color":"text-orange-500","status":"published","sort":4,"features":["Thèmes modernes personnalisables","Paiement natif via DommPay","Gestion des stocks en temps réel","SEO optimisé dès la mise en ligne"]}	{"name":"DommShop","slug":"dommshop","description":"Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.","icon":"ShoppingBag","color":"text-orange-500","status":"published","sort":4,"features":["Thèmes modernes personnalisables","Paiement natif via DommPay","Gestion des stocks en temps réel","SEO optimisé dès la mise en ligne"]}	\N	\N
84	102	products	2a2fbf26-930b-42ec-881d-49ed6327e6f9	{"id":"2a2fbf26-930b-42ec-881d-49ed6327e6f9","status":"published","sort":1,"date_created":"2026-02-04T17:14:10.017Z","date_updated":"2026-02-04T17:38:16.020Z","name":"DommPay","slug":"dommpay","description":"Solution de paiement unifiée et multi-devise. Acceptez et envoyez des paiements partout.","content":null,"icon":"Wallet","color":"text-emerald-500","image":null,"features":["Paiements multi-devises (EUR, XOF, USD...)","Intégration en quelques lignes de code","Tableau de bord transactionnel en temps réel","Conformité réglementaire automatique"]}	{"features":["Paiements multi-devises (EUR, XOF, USD...)","Intégration en quelques lignes de code","Tableau de bord transactionnel en temps réel","Conformité réglementaire automatique"],"date_updated":"2026-02-04T17:38:16.020Z"}	\N	\N
85	103	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-04T17:38:16.057Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","image":null,"features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"]}	{"features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"date_updated":"2026-02-04T17:38:16.057Z"}	\N	\N
86	104	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"id":"c5ce8492-a63a-4f34-a099-8368179a57ec","status":"published","sort":3,"date_created":"2026-02-04T17:14:10.060Z","date_updated":"2026-02-04T17:38:16.090Z","name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","content":null,"icon":"Users","color":"text-violet-500","image":null,"features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"]}	{"features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"],"date_updated":"2026-02-04T17:38:16.090Z"}	\N	\N
87	105	newsletter_subscribers	9a46a93e-f0e1-45e3-96fd-324b7d9cbd59	{"email":"dedsqdqsd@gmail.com"}	{"email":"dedsqdqsd@gmail.com"}	\N	\N
88	107	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	{"status":"published","sort":1,"title":"Comment le paiement mobile transforme le commerce en Afrique","slug":"paiement-mobile-commerce-afrique","excerpt":"Le paiement mobile connaît une croissance exponentielle. Découvrez comment cette révolution redéfinit les échanges commerciaux et ouvre de nouvelles opportunités.","content":"<p>Le paiement mobile est en train de transformer radicalement la manière dont les transactions commerciales sont effectuées. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une référence mondiale.</p><h2>Une adoption sans précédent</h2><p>Le mobile money s'est imposé comme le moyen de paiement digital de référence dans de nombreux marchés. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connectée, un faible taux de bancarisation traditionnelle, et des solutions adaptées aux réalités locales.</p><h2>L'impact sur le commerce</h2><p>Les commerçants bénéficient désormais d'outils qui leur permettent d'accepter des paiements de manière sécurisée et instantanée. Cette digitalisation des échanges favorise la traçabilité, réduit les risques liés au cash et ouvre l'accès à de nouveaux marchés.</p><h2>DommPay au cœur de cette transformation</h2><p>Chez DOMMSOFT, nous avons conçu DommPay pour répondre précisément à ces enjeux. Notre solution intègre les principaux opérateurs mobile money et offre une expérience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>","date_published":"2026-01-28T10:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Paiement","Mobile Money","Fintech"]}	{"status":"published","sort":1,"title":"Comment le paiement mobile transforme le commerce en Afrique","slug":"paiement-mobile-commerce-afrique","excerpt":"Le paiement mobile connaît une croissance exponentielle. Découvrez comment cette révolution redéfinit les échanges commerciaux et ouvre de nouvelles opportunités.","content":"<p>Le paiement mobile est en train de transformer radicalement la manière dont les transactions commerciales sont effectuées. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une référence mondiale.</p><h2>Une adoption sans précédent</h2><p>Le mobile money s'est imposé comme le moyen de paiement digital de référence dans de nombreux marchés. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connectée, un faible taux de bancarisation traditionnelle, et des solutions adaptées aux réalités locales.</p><h2>L'impact sur le commerce</h2><p>Les commerçants bénéficient désormais d'outils qui leur permettent d'accepter des paiements de manière sécurisée et instantanée. Cette digitalisation des échanges favorise la traçabilité, réduit les risques liés au cash et ouvre l'accès à de nouveaux marchés.</p><h2>DommPay au cœur de cette transformation</h2><p>Chez DOMMSOFT, nous avons conçu DommPay pour répondre précisément à ces enjeux. Notre solution intègre les principaux opérateurs mobile money et offre une expérience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>","date_published":"2026-01-28T10:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Paiement","Mobile Money","Fintech"]}	\N	\N
89	108	blog_posts	ae96ffc9-2863-4051-8186-fa1db62fe7e1	{"status":"published","sort":2,"title":"Cloud souverain : pourquoi repenser son hébergement","slug":"cloud-souverain-hebergement","excerpt":"La souveraineté des données est un enjeu majeur. Explorons pourquoi un cloud adapté aux réalités locales est essentiel pour les entreprises.","content":"<p>La question de la souveraineté numérique n'a jamais été aussi pertinente. Alors que les données deviennent le nouvel or noir, les entreprises doivent s'interroger sur où et comment leurs données sont stockées.</p><h2>Les enjeux de la localisation des données</h2><p>Héberger ses données sur des serveurs distants pose des questions juridiques, de performance et de sécurité. Les latences réseau, la conformité aux réglementations locales et la dépendance à des fournisseurs étrangers sont autant de défis à relever.</p><h2>Une infrastructure adaptée</h2><p>DommCloud a été pensé pour offrir une alternative crédible. En proposant des solutions d'hébergement optimisées, nous garantissons des performances élevées, une conformité réglementaire et un support de proximité.</p><h2>Vers une autonomie numérique</h2><p>L'avenir du cloud passe par le développement d'infrastructures locales de qualité. C'est un investissement stratégique qui permettra aux entreprises de garder le contrôle sur leurs données tout en bénéficiant des avantages du cloud computing.</p>","date_published":"2026-01-20T14:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Cloud","Souveraineté","Infrastructure"]}	{"status":"published","sort":2,"title":"Cloud souverain : pourquoi repenser son hébergement","slug":"cloud-souverain-hebergement","excerpt":"La souveraineté des données est un enjeu majeur. Explorons pourquoi un cloud adapté aux réalités locales est essentiel pour les entreprises.","content":"<p>La question de la souveraineté numérique n'a jamais été aussi pertinente. Alors que les données deviennent le nouvel or noir, les entreprises doivent s'interroger sur où et comment leurs données sont stockées.</p><h2>Les enjeux de la localisation des données</h2><p>Héberger ses données sur des serveurs distants pose des questions juridiques, de performance et de sécurité. Les latences réseau, la conformité aux réglementations locales et la dépendance à des fournisseurs étrangers sont autant de défis à relever.</p><h2>Une infrastructure adaptée</h2><p>DommCloud a été pensé pour offrir une alternative crédible. En proposant des solutions d'hébergement optimisées, nous garantissons des performances élevées, une conformité réglementaire et un support de proximité.</p><h2>Vers une autonomie numérique</h2><p>L'avenir du cloud passe par le développement d'infrastructures locales de qualité. C'est un investissement stratégique qui permettra aux entreprises de garder le contrôle sur leurs données tout en bénéficiant des avantages du cloud computing.</p>","date_published":"2026-01-20T14:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Cloud","Souveraineté","Infrastructure"]}	\N	\N
90	109	blog_posts	f307be56-5f9d-4c5b-995d-eb4f9b2fbbd5	{"status":"published","sort":3,"title":"Digitaliser la gestion RH : un levier de croissance pour les PME","slug":"digitaliser-gestion-rh-pme","excerpt":"La gestion des ressources humaines reste un défi pour de nombreuses PME. Découvrez comment la digitalisation peut simplifier vos processus.","content":"<p>Pour beaucoup de PME, la gestion des ressources humaines reste un processus manuel, chronophage et source d'erreurs. Fiches de paie calculées à la main, suivi des congés sur tableur, absence de reporting... Ces pratiques freinent la croissance.</p><h2>Les bénéfices concrets de la digitalisation</h2><p>Automatiser la gestion RH permet de réduire les erreurs de calcul de paie, de centraliser les informations collaborateurs, de suivre les performances en temps réel et de se conformer facilement aux obligations légales.</p><h2>DommHR : pensé pour les réalités locales</h2><p>DommHR intègre les spécificités réglementaires locales : calcul automatique des cotisations sociales, gestion multi-devises et interface disponible en français.</p><h2>Un investissement rentable</h2><p>Le retour sur investissement d'un outil RH digital se mesure rapidement : gain de temps, réduction des erreurs, meilleure satisfaction des collaborateurs et prise de décision éclairée grâce aux données.</p>","date_published":"2026-01-12T09:00:00.000Z","author":"Équipe DOMMSOFT","tags":["RH","Digitalisation","PME"]}	{"status":"published","sort":3,"title":"Digitaliser la gestion RH : un levier de croissance pour les PME","slug":"digitaliser-gestion-rh-pme","excerpt":"La gestion des ressources humaines reste un défi pour de nombreuses PME. Découvrez comment la digitalisation peut simplifier vos processus.","content":"<p>Pour beaucoup de PME, la gestion des ressources humaines reste un processus manuel, chronophage et source d'erreurs. Fiches de paie calculées à la main, suivi des congés sur tableur, absence de reporting... Ces pratiques freinent la croissance.</p><h2>Les bénéfices concrets de la digitalisation</h2><p>Automatiser la gestion RH permet de réduire les erreurs de calcul de paie, de centraliser les informations collaborateurs, de suivre les performances en temps réel et de se conformer facilement aux obligations légales.</p><h2>DommHR : pensé pour les réalités locales</h2><p>DommHR intègre les spécificités réglementaires locales : calcul automatique des cotisations sociales, gestion multi-devises et interface disponible en français.</p><h2>Un investissement rentable</h2><p>Le retour sur investissement d'un outil RH digital se mesure rapidement : gain de temps, réduction des erreurs, meilleure satisfaction des collaborateurs et prise de décision éclairée grâce aux données.</p>","date_published":"2026-01-12T09:00:00.000Z","author":"Équipe DOMMSOFT","tags":["RH","Digitalisation","PME"]}	\N	\N
91	110	blog_posts	97759a4e-2232-4a71-8a76-fd758ffee3c0	{"status":"published","sort":4,"title":"E-commerce : les clés pour réussir sa boutique en ligne","slug":"ecommerce-cles-reussite","excerpt":"Le e-commerce est en plein essor. Voici les facteurs clés de succès pour lancer et développer une boutique en ligne performante.","content":"<p>Le marché du e-commerce continue sa croissance fulgurante. Cette dynamique représente une opportunité immense pour les entrepreneurs qui sauront s'adapter aux spécificités de leur marché.</p><h2>Comprendre son marché</h2><p>Le e-commerce a ses propres codes selon les régions. Le paiement à la livraison reste dominant dans de nombreux marchés, la logistique du dernier kilomètre est un défi majeur, et la confiance se construit progressivement.</p><h2>Choisir les bons outils</h2><p>Une plateforme e-commerce adaptée doit intégrer les moyens de paiement locaux, proposer une gestion logistique flexible et offrir une expérience mobile-first, la majorité du trafic provenant des smartphones.</p><h2>DommShop : votre allié e-commerce</h2><p>Avec DommShop, nous avons créé une plateforme qui répond à ces exigences. Intégration native de DommPay pour les paiements, gestion de catalogue intuitive, et outils marketing intégrés pour développer votre audience.</p>","date_published":"2026-01-05T11:00:00.000Z","author":"Équipe DOMMSOFT","tags":["E-commerce","Entrepreneuriat","Digital"]}	{"status":"published","sort":4,"title":"E-commerce : les clés pour réussir sa boutique en ligne","slug":"ecommerce-cles-reussite","excerpt":"Le e-commerce est en plein essor. Voici les facteurs clés de succès pour lancer et développer une boutique en ligne performante.","content":"<p>Le marché du e-commerce continue sa croissance fulgurante. Cette dynamique représente une opportunité immense pour les entrepreneurs qui sauront s'adapter aux spécificités de leur marché.</p><h2>Comprendre son marché</h2><p>Le e-commerce a ses propres codes selon les régions. Le paiement à la livraison reste dominant dans de nombreux marchés, la logistique du dernier kilomètre est un défi majeur, et la confiance se construit progressivement.</p><h2>Choisir les bons outils</h2><p>Une plateforme e-commerce adaptée doit intégrer les moyens de paiement locaux, proposer une gestion logistique flexible et offrir une expérience mobile-first, la majorité du trafic provenant des smartphones.</p><h2>DommShop : votre allié e-commerce</h2><p>Avec DommShop, nous avons créé une plateforme qui répond à ces exigences. Intégration native de DommPay pour les paiements, gestion de catalogue intuitive, et outils marketing intégrés pour développer votre audience.</p>","date_published":"2026-01-05T11:00:00.000Z","author":"Équipe DOMMSOFT","tags":["E-commerce","Entrepreneuriat","Digital"]}	\N	\N
92	111	blog_posts	399e5f59-5281-47b5-bd51-1e02c0f97e02	{"status":"published","sort":5,"title":"5 tendances tech à suivre en 2026 pour les entreprises innovantes","slug":"tendances-tech-2026-entreprises","excerpt":"Intelligence artificielle, edge computing, fintech embarquée... Tour d'horizon des tendances technologiques qui façonneront l'année 2026.","content":"<p>L'année 2026 s'annonce riche en innovations technologiques. Pour les entreprises qui veulent rester compétitives, il est essentiel de comprendre et d'anticiper ces évolutions.</p><h2>1. L'IA générative au service des métiers</h2><p>Au-delà du buzz, l'IA générative commence à trouver des applications concrètes en entreprise : automatisation du support client, génération de contenu, analyse prédictive et optimisation des processus.</p><h2>2. La fintech embarquée</h2><p>Les services financiers s'intègrent directement dans les applications non-financières. Paiement, crédit, assurance : ces fonctionnalités deviennent des briques que toute plateforme peut intégrer.</p><h2>3. L'edge computing</h2><p>Avec la multiplication des objets connectés et le besoin de temps réel, le traitement des données se rapproche de leur source de production.</p><h2>4. La cybersécurité proactive</h2><p>Face à la sophistication croissante des menaces, les entreprises passent d'une approche réactive à une posture proactive, avec des outils de détection et de réponse automatisés.</p><h2>5. Le low-code/no-code</h2><p>Ces plateformes démocratisent le développement d'applications et permettent aux équipes métier de créer leurs propres outils sans dépendre entièrement des développeurs.</p>","date_published":"2025-12-28T08:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Tendances","Innovation","Tech"]}	{"status":"published","sort":5,"title":"5 tendances tech à suivre en 2026 pour les entreprises innovantes","slug":"tendances-tech-2026-entreprises","excerpt":"Intelligence artificielle, edge computing, fintech embarquée... Tour d'horizon des tendances technologiques qui façonneront l'année 2026.","content":"<p>L'année 2026 s'annonce riche en innovations technologiques. Pour les entreprises qui veulent rester compétitives, il est essentiel de comprendre et d'anticiper ces évolutions.</p><h2>1. L'IA générative au service des métiers</h2><p>Au-delà du buzz, l'IA générative commence à trouver des applications concrètes en entreprise : automatisation du support client, génération de contenu, analyse prédictive et optimisation des processus.</p><h2>2. La fintech embarquée</h2><p>Les services financiers s'intègrent directement dans les applications non-financières. Paiement, crédit, assurance : ces fonctionnalités deviennent des briques que toute plateforme peut intégrer.</p><h2>3. L'edge computing</h2><p>Avec la multiplication des objets connectés et le besoin de temps réel, le traitement des données se rapproche de leur source de production.</p><h2>4. La cybersécurité proactive</h2><p>Face à la sophistication croissante des menaces, les entreprises passent d'une approche réactive à une posture proactive, avec des outils de détection et de réponse automatisés.</p><h2>5. Le low-code/no-code</h2><p>Ces plateformes démocratisent le développement d'applications et permettent aux équipes métier de créer leurs propres outils sans dépendre entièrement des développeurs.</p>","date_published":"2025-12-28T08:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Tendances","Innovation","Tech"]}	\N	\N
93	112	directus_fields	22	{"id":22,"collection":"blog_posts","field":"cover_image","special":["file"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":"Image de couverture","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"blog_posts","field":"cover_image","interface":null}	\N	\N
94	113	directus_fields	22	{"id":22,"collection":"blog_posts","field":"cover_image","special":["file"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":"Image de couverture","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"blog_posts","field":"cover_image","interface":"input","display":null}	\N	\N
95	114	directus_fields	22	{"id":22,"collection":"blog_posts","field":"cover_image","special":["file"],"interface":null,"options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":"Image de couverture","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"blog_posts","field":"cover_image","interface":null}	\N	\N
96	118	directus_fields	60	{"sort":10,"interface":"file-image","display":"image","special":["file"],"note":"Image de couverture","required":false,"width":"full","collection":"blog_posts","field":"cover_image"}	{"sort":10,"interface":"file-image","display":"image","special":["file"],"note":"Image de couverture","required":false,"width":"full","collection":"blog_posts","field":"cover_image"}	\N	\N
97	119	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"fr-FR","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"default_language":"fr-FR"}	\N	\N
98	123	directus_fields	61	{"sort":14,"interface":"file-image","display":"image","special":["file"],"note":"Image de couverture","required":false,"width":"full","collection":"blog_posts","field":"cover_image"}	{"sort":14,"interface":"file-image","display":"image","special":["file"],"note":"Image de couverture","required":false,"width":"full","collection":"blog_posts","field":"cover_image"}	\N	\N
99	125	directus_folders	636a26fa-1c70-4f9e-a125-100f2af93883	{"name":"blog"}	{"name":"blog"}	\N	\N
100	126	directus_fields	62	{"sort":14,"interface":"file-image","special":["file"],"options":{"folder":"636a26fa-1c70-4f9e-a125-100f2af93883","letterbox":true},"collection":"blog_posts","field":"cover_image"}	{"sort":14,"interface":"file-image","special":["file"],"options":{"folder":"636a26fa-1c70-4f9e-a125-100f2af93883","letterbox":true},"collection":"blog_posts","field":"cover_image"}	\N	\N
101	127	directus_files	55a318cc-ae6b-48a6-9865-3bbc83f20982	{"folder":"636a26fa-1c70-4f9e-a125-100f2af93883","title":"Capture D’écran 2026 02 02 À 09.23.42 (2)","filename_download":"Capture d’écran 2026-02-02 à 09.23.42 (2).png","type":"image/png","storage":"local"}	{"folder":"636a26fa-1c70-4f9e-a125-100f2af93883","title":"Capture D’écran 2026 02 02 À 09.23.42 (2)","filename_download":"Capture d’écran 2026-02-02 à 09.23.42 (2).png","type":"image/png","storage":"local"}	\N	\N
118	146	job_offers	60f53ced-681e-440b-aa6d-dd683fa3a202	{"status":"published","sort":1,"title":"Développeur Full-Stack Senior","slug":"developpeur-fullstack-senior","department":"Ingénierie","location":"Cotonou, Bénin","type":"CDI","description":"Rejoignez notre équipe technique pour concevoir et développer des solutions innovantes. Vous travaillerez sur l'ensemble de notre stack technique, du backend aux interfaces utilisateur.","content":"<h2>À propos du poste</h2><p>En tant que Développeur Full-Stack Senior, vous jouerez un rôle clé dans la conception et le développement de nos produits phares : DommPay, DommCloud, DommHR et DommShop.</p><h2>Responsabilités</h2><ul><li>Concevoir et développer des fonctionnalités front-end et back-end</li><li>Participer aux revues de code et au mentorat des développeurs juniors</li><li>Collaborer avec l'équipe produit pour définir les spécifications techniques</li><li>Assurer la qualité du code et la couverture de tests</li><li>Contribuer à l'architecture technique des projets</li></ul><h2>Profil recherché</h2><ul><li>5+ ans d'expérience en développement web</li><li>Maîtrise de React/Next.js et Node.js</li><li>Expérience avec PostgreSQL et les API REST</li><li>Connaissance de TypeScript</li><li>Capacité à travailler en équipe dans un environnement agile</li></ul><h2>Ce que nous offrons</h2><ul><li>Salaire compétitif et avantages sociaux</li><li>Télétravail flexible</li><li>Budget formation annuel</li><li>Équipement de travail fourni</li><li>Environnement de travail stimulant et bienveillant</li></ul>","date_published":"2026-01-30T09:00:00.000Z"}	{"status":"published","sort":1,"title":"Développeur Full-Stack Senior","slug":"developpeur-fullstack-senior","department":"Ingénierie","location":"Cotonou, Bénin","type":"CDI","description":"Rejoignez notre équipe technique pour concevoir et développer des solutions innovantes. Vous travaillerez sur l'ensemble de notre stack technique, du backend aux interfaces utilisateur.","content":"<h2>À propos du poste</h2><p>En tant que Développeur Full-Stack Senior, vous jouerez un rôle clé dans la conception et le développement de nos produits phares : DommPay, DommCloud, DommHR et DommShop.</p><h2>Responsabilités</h2><ul><li>Concevoir et développer des fonctionnalités front-end et back-end</li><li>Participer aux revues de code et au mentorat des développeurs juniors</li><li>Collaborer avec l'équipe produit pour définir les spécifications techniques</li><li>Assurer la qualité du code et la couverture de tests</li><li>Contribuer à l'architecture technique des projets</li></ul><h2>Profil recherché</h2><ul><li>5+ ans d'expérience en développement web</li><li>Maîtrise de React/Next.js et Node.js</li><li>Expérience avec PostgreSQL et les API REST</li><li>Connaissance de TypeScript</li><li>Capacité à travailler en équipe dans un environnement agile</li></ul><h2>Ce que nous offrons</h2><ul><li>Salaire compétitif et avantages sociaux</li><li>Télétravail flexible</li><li>Budget formation annuel</li><li>Équipement de travail fourni</li><li>Environnement de travail stimulant et bienveillant</li></ul>","date_published":"2026-01-30T09:00:00.000Z"}	\N	\N
135	165	directus_fields	88	{"sort":15,"interface":"input-rich-text-html","width":"full","note":"Mentions légales","group":null,"collection":"site_settings","field":"legal_mentions"}	{"sort":15,"interface":"input-rich-text-html","width":"full","note":"Mentions légales","group":null,"collection":"site_settings","field":"legal_mentions"}	\N	\N
102	128	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	{"id":"5b444ec8-5a61-4abe-ad30-bd0af5916dd3","status":"published","sort":1,"date_created":"2026-02-04T17:52:23.544Z","date_updated":"2026-02-04T18:02:49.176Z","title":"Comment le paiement mobile transforme le commerce en Afrique","slug":"paiement-mobile-commerce-afrique","excerpt":"Le paiement mobile connaît une croissance exponentielle. Découvrez comment cette révolution redéfinit les échanges commerciaux et ouvre de nouvelles opportunités.","content":"<p>Le paiement mobile est en train de transformer radicalement la manière dont les transactions commerciales sont effectuées. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une référence mondiale.</p><h2>Une adoption sans précédent</h2><p>Le mobile money s'est imposé comme le moyen de paiement digital de référence dans de nombreux marchés. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connectée, un faible taux de bancarisation traditionnelle, et des solutions adaptées aux réalités locales.</p><h2>L'impact sur le commerce</h2><p>Les commerçants bénéficient désormais d'outils qui leur permettent d'accepter des paiements de manière sécurisée et instantanée. Cette digitalisation des échanges favorise la traçabilité, réduit les risques liés au cash et ouvre l'accès à de nouveaux marchés.</p><h2>DommPay au cœur de cette transformation</h2><p>Chez DOMMSOFT, nous avons conçu DommPay pour répondre précisément à ces enjeux. Notre solution intègre les principaux opérateurs mobile money et offre une expérience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>","date_published":"2026-01-28T10:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Paiement","Mobile Money","Fintech"],"cover_image":"55a318cc-ae6b-48a6-9865-3bbc83f20982"}	{"cover_image":"55a318cc-ae6b-48a6-9865-3bbc83f20982","date_updated":"2026-02-04T18:02:49.176Z"}	\N	\N
103	130	directus_fields	63	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"job_offers"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"job_offers"}	\N	\N
104	131	directus_fields	64	{"sort":2,"interface":"select-dropdown","display":"labels","width":"half","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]},"default_value":"draft","field":"status","collection":"job_offers"}	{"sort":2,"interface":"select-dropdown","display":"labels","width":"half","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"},{"text":"Archived","value":"archived"}]},"default_value":"draft","field":"status","collection":"job_offers"}	\N	\N
105	132	directus_fields	65	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"job_offers"}	{"sort":3,"interface":"input","hidden":true,"field":"sort","collection":"job_offers"}	\N	\N
106	133	directus_fields	66	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"job_offers"}	{"sort":4,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"job_offers"}	\N	\N
107	134	directus_fields	67	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"job_offers"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_updated","collection":"job_offers"}	\N	\N
108	135	directus_fields	68	{"sort":6,"interface":"input","width":"full","required":true,"note":"Titre du poste","field":"title","collection":"job_offers"}	{"sort":6,"interface":"input","width":"full","required":true,"note":"Titre du poste","field":"title","collection":"job_offers"}	\N	\N
109	136	directus_fields	69	{"sort":7,"interface":"input","width":"half","required":true,"note":"URL slug","field":"slug","collection":"job_offers"}	{"sort":7,"interface":"input","width":"half","required":true,"note":"URL slug","field":"slug","collection":"job_offers"}	\N	\N
110	137	directus_fields	70	{"sort":8,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Ingénierie","value":"Ingénierie"},{"text":"Design","value":"Design"},{"text":"Marketing","value":"Marketing"},{"text":"Ventes","value":"Ventes"},{"text":"Opérations","value":"Opérations"}]},"required":true,"field":"department","collection":"job_offers"}	{"sort":8,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Ingénierie","value":"Ingénierie"},{"text":"Design","value":"Design"},{"text":"Marketing","value":"Marketing"},{"text":"Ventes","value":"Ventes"},{"text":"Opérations","value":"Opérations"}]},"required":true,"field":"department","collection":"job_offers"}	\N	\N
111	138	directus_fields	71	{"sort":9,"interface":"input","width":"half","note":"Ex: Cotonou, Bénin / Remote","field":"location","collection":"job_offers"}	{"sort":9,"interface":"input","width":"half","note":"Ex: Cotonou, Bénin / Remote","field":"location","collection":"job_offers"}	\N	\N
112	139	directus_fields	72	{"sort":10,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"CDI","value":"CDI"},{"text":"CDD","value":"CDD"},{"text":"Stage","value":"Stage"},{"text":"Freelance","value":"Freelance"}]},"required":true,"field":"type","collection":"job_offers"}	{"sort":10,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"CDI","value":"CDI"},{"text":"CDD","value":"CDD"},{"text":"Stage","value":"Stage"},{"text":"Freelance","value":"Freelance"}]},"required":true,"field":"type","collection":"job_offers"}	\N	\N
113	140	directus_fields	73	{"sort":11,"interface":"input-multiline","width":"full","note":"Court résumé (2-3 phrases)","field":"description","collection":"job_offers"}	{"sort":11,"interface":"input-multiline","width":"full","note":"Court résumé (2-3 phrases)","field":"description","collection":"job_offers"}	\N	\N
114	141	directus_fields	74	{"sort":12,"interface":"input-rich-text-html","width":"full","note":"Description complète du poste","field":"content","collection":"job_offers"}	{"sort":12,"interface":"input-rich-text-html","width":"full","note":"Description complète du poste","field":"content","collection":"job_offers"}	\N	\N
115	142	directus_fields	75	{"sort":13,"interface":"datetime","width":"half","field":"date_published","collection":"job_offers"}	{"sort":13,"interface":"datetime","width":"half","field":"date_published","collection":"job_offers"}	\N	\N
116	143	directus_collections	job_offers	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"icon":"work","collection":"job_offers"}	{"sort_field":"sort","archive_field":"status","archive_value":"archived","unarchive_value":"draft","singleton":false,"icon":"work","collection":"job_offers"}	\N	\N
117	144	directus_permissions	8	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"job_offers","action":"read","fields":["*"]}	{"policy":"abf8a154-5b1c-4a46-ac9c-7300570f4f17","collection":"job_offers","action":"read","fields":["*"]}	\N	\N
119	147	job_offers	c550eba6-00ef-403e-b3b8-c0223dce56d8	{"status":"published","sort":2,"title":"Designer UI/UX","slug":"designer-ui-ux","department":"Design","location":"Remote","type":"CDI","description":"Nous cherchons un designer talentueux pour créer des interfaces intuitives et esthétiques. Vous serez au cœur de l'expérience utilisateur de nos produits.","content":"<h2>À propos du poste</h2><p>En tant que Designer UI/UX, vous serez responsable de l'expérience utilisateur de l'ensemble de nos produits digitaux. Vous travaillerez en étroite collaboration avec les développeurs et l'équipe produit.</p><h2>Responsabilités</h2><ul><li>Concevoir des maquettes et prototypes interactifs</li><li>Mener des recherches utilisateurs et des tests d'usabilité</li><li>Créer et maintenir notre design system</li><li>Collaborer avec les développeurs pour assurer la fidélité des implémentations</li><li>Contribuer à la stratégie produit</li></ul><h2>Profil recherché</h2><ul><li>3+ ans d'expérience en design UI/UX</li><li>Maîtrise de Figma</li><li>Portfolio démontrant une approche centrée utilisateur</li><li>Sensibilité pour l'accessibilité et le design inclusif</li><li>Bonne communication en français et en anglais</li></ul><h2>Ce que nous offrons</h2><ul><li>Travail 100% remote</li><li>Horaires flexibles</li><li>Licence Figma et outils de design</li><li>Participation à des conférences design</li><li>Équipe créative et collaborative</li></ul>","date_published":"2026-01-25T10:00:00.000Z"}	{"status":"published","sort":2,"title":"Designer UI/UX","slug":"designer-ui-ux","department":"Design","location":"Remote","type":"CDI","description":"Nous cherchons un designer talentueux pour créer des interfaces intuitives et esthétiques. Vous serez au cœur de l'expérience utilisateur de nos produits.","content":"<h2>À propos du poste</h2><p>En tant que Designer UI/UX, vous serez responsable de l'expérience utilisateur de l'ensemble de nos produits digitaux. Vous travaillerez en étroite collaboration avec les développeurs et l'équipe produit.</p><h2>Responsabilités</h2><ul><li>Concevoir des maquettes et prototypes interactifs</li><li>Mener des recherches utilisateurs et des tests d'usabilité</li><li>Créer et maintenir notre design system</li><li>Collaborer avec les développeurs pour assurer la fidélité des implémentations</li><li>Contribuer à la stratégie produit</li></ul><h2>Profil recherché</h2><ul><li>3+ ans d'expérience en design UI/UX</li><li>Maîtrise de Figma</li><li>Portfolio démontrant une approche centrée utilisateur</li><li>Sensibilité pour l'accessibilité et le design inclusif</li><li>Bonne communication en français et en anglais</li></ul><h2>Ce que nous offrons</h2><ul><li>Travail 100% remote</li><li>Horaires flexibles</li><li>Licence Figma et outils de design</li><li>Participation à des conférences design</li><li>Équipe créative et collaborative</li></ul>","date_published":"2026-01-25T10:00:00.000Z"}	\N	\N
120	148	job_offers	c498ecb2-2677-475f-8538-9acea310f4b1	{"status":"published","sort":3,"title":"Chef de Projet Digital","slug":"chef-de-projet-digital","department":"Opérations","location":"Cotonou, Bénin","type":"CDI","description":"Pilotez nos projets digitaux de A à Z. Vous coordonnerez les équipes techniques et créatives pour livrer des solutions de qualité dans les délais.","content":"<h2>À propos du poste</h2><p>Le Chef de Projet Digital sera le garant de la bonne exécution de nos projets, de la phase de cadrage jusqu'à la livraison. Vous serez l'interface entre nos clients internes, l'équipe technique et la direction.</p><h2>Responsabilités</h2><ul><li>Planifier et piloter les projets digitaux</li><li>Coordonner les équipes de développement et design</li><li>Gérer les budgets et les délais</li><li>Assurer la communication avec les parties prenantes</li><li>Identifier et gérer les risques projet</li></ul><h2>Profil recherché</h2><ul><li>3+ ans d'expérience en gestion de projets digitaux</li><li>Connaissance des méthodologies agiles (Scrum, Kanban)</li><li>Excellentes capacités de communication</li><li>Sens de l'organisation et rigueur</li><li>Compréhension des enjeux techniques</li></ul><h2>Ce que nous offrons</h2><ul><li>Rôle clé dans une entreprise en croissance</li><li>Projets variés et stimulants</li><li>Formation continue en management</li><li>Environnement multiculturel</li><li>Perspectives d'évolution rapide</li></ul>","date_published":"2026-01-18T08:00:00.000Z"}	{"status":"published","sort":3,"title":"Chef de Projet Digital","slug":"chef-de-projet-digital","department":"Opérations","location":"Cotonou, Bénin","type":"CDI","description":"Pilotez nos projets digitaux de A à Z. Vous coordonnerez les équipes techniques et créatives pour livrer des solutions de qualité dans les délais.","content":"<h2>À propos du poste</h2><p>Le Chef de Projet Digital sera le garant de la bonne exécution de nos projets, de la phase de cadrage jusqu'à la livraison. Vous serez l'interface entre nos clients internes, l'équipe technique et la direction.</p><h2>Responsabilités</h2><ul><li>Planifier et piloter les projets digitaux</li><li>Coordonner les équipes de développement et design</li><li>Gérer les budgets et les délais</li><li>Assurer la communication avec les parties prenantes</li><li>Identifier et gérer les risques projet</li></ul><h2>Profil recherché</h2><ul><li>3+ ans d'expérience en gestion de projets digitaux</li><li>Connaissance des méthodologies agiles (Scrum, Kanban)</li><li>Excellentes capacités de communication</li><li>Sens de l'organisation et rigueur</li><li>Compréhension des enjeux techniques</li></ul><h2>Ce que nous offrons</h2><ul><li>Rôle clé dans une entreprise en croissance</li><li>Projets variés et stimulants</li><li>Formation continue en management</li><li>Environnement multiculturel</li><li>Perspectives d'évolution rapide</li></ul>","date_published":"2026-01-18T08:00:00.000Z"}	\N	\N
121	150	directus_fields	76	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"applications"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"applications"}	\N	\N
122	151	directus_fields	77	{"sort":2,"interface":"select-dropdown","display":"labels","width":"half","options":{"choices":[{"text":"Nouveau","value":"new"},{"text":"Examiné","value":"reviewed"},{"text":"Entretien","value":"interview"},{"text":"Accepté","value":"accepted"},{"text":"Refusé","value":"rejected"}]},"default_value":"new","field":"status","collection":"applications"}	{"sort":2,"interface":"select-dropdown","display":"labels","width":"half","options":{"choices":[{"text":"Nouveau","value":"new"},{"text":"Examiné","value":"reviewed"},{"text":"Entretien","value":"interview"},{"text":"Accepté","value":"accepted"},{"text":"Refusé","value":"rejected"}]},"default_value":"new","field":"status","collection":"applications"}	\N	\N
123	152	directus_fields	78	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"applications"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","field":"date_created","collection":"applications"}	\N	\N
124	153	directus_fields	79	{"sort":4,"interface":"input","width":"half","required":true,"note":"Prénom","field":"first_name","collection":"applications"}	{"sort":4,"interface":"input","width":"half","required":true,"note":"Prénom","field":"first_name","collection":"applications"}	\N	\N
125	154	directus_fields	80	{"sort":5,"interface":"input","width":"half","required":true,"note":"Nom","field":"last_name","collection":"applications"}	{"sort":5,"interface":"input","width":"half","required":true,"note":"Nom","field":"last_name","collection":"applications"}	\N	\N
126	155	directus_fields	81	{"sort":6,"interface":"input","width":"half","required":true,"note":"Email","field":"email","collection":"applications"}	{"sort":6,"interface":"input","width":"half","required":true,"note":"Email","field":"email","collection":"applications"}	\N	\N
127	156	directus_fields	82	{"sort":7,"interface":"input","width":"half","note":"Téléphone","field":"phone","collection":"applications"}	{"sort":7,"interface":"input","width":"half","note":"Téléphone","field":"phone","collection":"applications"}	\N	\N
128	157	directus_fields	83	{"sort":8,"interface":"input","width":"half","required":true,"note":"Pays","field":"country","collection":"applications"}	{"sort":8,"interface":"input","width":"half","required":true,"note":"Pays","field":"country","collection":"applications"}	\N	\N
129	158	directus_fields	84	{"sort":9,"interface":"input","width":"half","readonly":true,"note":"Poste visé","field":"job_title","collection":"applications"}	{"sort":9,"interface":"input","width":"half","readonly":true,"note":"Poste visé","field":"job_title","collection":"applications"}	\N	\N
130	159	directus_fields	85	{"sort":10,"interface":"input","width":"half","hidden":true,"field":"job_slug","collection":"applications"}	{"sort":10,"interface":"input","width":"half","hidden":true,"field":"job_slug","collection":"applications"}	\N	\N
131	160	directus_fields	86	{"sort":11,"interface":"input-multiline","width":"full","note":"Quelques lignes de motivation","field":"motivation","collection":"applications"}	{"sort":11,"interface":"input-multiline","width":"full","note":"Quelques lignes de motivation","field":"motivation","collection":"applications"}	\N	\N
132	161	directus_collections	applications	{"icon":"assignment_ind","singleton":false,"collection":"applications"}	{"icon":"assignment_ind","singleton":false,"collection":"applications"}	\N	\N
133	162	directus_fields	87	{"sort":12,"interface":"file","display":"file","special":["file"],"note":"CV (PDF, DOC, DOCX)","width":"full","collection":"applications","field":"cv"}	{"sort":12,"interface":"file","display":"file","special":["file"],"note":"CV (PDF, DOC, DOCX)","width":"full","collection":"applications","field":"cv"}	\N	\N
134	163	job_offers	c550eba6-00ef-403e-b3b8-c0223dce56d8	{"id":"c550eba6-00ef-403e-b3b8-c0223dce56d8","status":"published","sort":2,"date_created":"2026-02-04T19:14:32.162Z","date_updated":"2026-02-04T20:01:21.977Z","title":"Designer UI/UX","slug":"designer-ui-ux","department":"Design","location":"Remote","type":"CDI","description":"Nous cherchons un designer talentueux pour créer des interfaces intuitives et esthétiques. Vous serez au cœur de l'expérience utilisateur de nos produits.","content":"<h3>&Agrave; propos du poste</h3>\\n<p>En tant que Designer UI/UX, vous serez responsable de l'exp&eacute;rience utilisateur de l'ensemble de nos produits digitaux. Vous travaillerez en &eacute;troite collaboration avec les d&eacute;veloppeurs et l'&eacute;quipe produit.</p>\\n<h2>Responsabilit&eacute;s</h2>\\n<ul>\\n<li>Concevoir des maquettes et prototypes interactifs</li>\\n<li>Mener des recherches utilisateurs et des tests d'usabilit&eacute;</li>\\n<li>Cr&eacute;er et maintenir notre design system</li>\\n<li>Collaborer avec les d&eacute;veloppeurs pour assurer la fid&eacute;lit&eacute; des impl&eacute;mentations</li>\\n<li>Contribuer &agrave; la strat&eacute;gie produit</li>\\n</ul>\\n<h2>Profil recherch&eacute;</h2>\\n<ul>\\n<li>3+ ans d'exp&eacute;rience en design UI/UX</li>\\n<li>Ma&icirc;trise de Figma</li>\\n<li>Portfolio d&eacute;montrant une approche centr&eacute;e utilisateur</li>\\n<li>Sensibilit&eacute; pour l'accessibilit&eacute; et le design inclusif</li>\\n<li>Bonne communication en fran&ccedil;ais et en anglais</li>\\n</ul>\\n<h2>Ce que nous offrons</h2>\\n<ul>\\n<li>Travail 100% remote</li>\\n<li>Horaires flexibles</li>\\n<li>Licence Figma et outils de design</li>\\n<li>Participation &agrave; des conf&eacute;rences design</li>\\n<li>&Eacute;quipe cr&eacute;ative et collaborative</li>\\n</ul>","date_published":"2026-01-25T10:00:00.000Z"}	{"content":"<h3>&Agrave; propos du poste</h3>\\n<p>En tant que Designer UI/UX, vous serez responsable de l'exp&eacute;rience utilisateur de l'ensemble de nos produits digitaux. Vous travaillerez en &eacute;troite collaboration avec les d&eacute;veloppeurs et l'&eacute;quipe produit.</p>\\n<h2>Responsabilit&eacute;s</h2>\\n<ul>\\n<li>Concevoir des maquettes et prototypes interactifs</li>\\n<li>Mener des recherches utilisateurs et des tests d'usabilit&eacute;</li>\\n<li>Cr&eacute;er et maintenir notre design system</li>\\n<li>Collaborer avec les d&eacute;veloppeurs pour assurer la fid&eacute;lit&eacute; des impl&eacute;mentations</li>\\n<li>Contribuer &agrave; la strat&eacute;gie produit</li>\\n</ul>\\n<h2>Profil recherch&eacute;</h2>\\n<ul>\\n<li>3+ ans d'exp&eacute;rience en design UI/UX</li>\\n<li>Ma&icirc;trise de Figma</li>\\n<li>Portfolio d&eacute;montrant une approche centr&eacute;e utilisateur</li>\\n<li>Sensibilit&eacute; pour l'accessibilit&eacute; et le design inclusif</li>\\n<li>Bonne communication en fran&ccedil;ais et en anglais</li>\\n</ul>\\n<h2>Ce que nous offrons</h2>\\n<ul>\\n<li>Travail 100% remote</li>\\n<li>Horaires flexibles</li>\\n<li>Licence Figma et outils de design</li>\\n<li>Participation &agrave; des conf&eacute;rences design</li>\\n<li>&Eacute;quipe cr&eacute;ative et collaborative</li>\\n</ul>","date_updated":"2026-02-04T20:01:21.977Z"}	\N	\N
136	166	directus_fields	89	{"sort":16,"interface":"input-rich-text-html","width":"full","note":"Politique de confidentialité","group":null,"collection":"site_settings","field":"privacy_policy"}	{"sort":16,"interface":"input-rich-text-html","width":"full","note":"Politique de confidentialité","group":null,"collection":"site_settings","field":"privacy_policy"}	\N	\N
137	167	directus_fields	90	{"sort":17,"interface":"input-rich-text-html","width":"full","note":"Conditions générales d'utilisation","group":null,"collection":"site_settings","field":"terms_of_use"}	{"sort":17,"interface":"input-rich-text-html","width":"full","note":"Conditions générales d'utilisation","group":null,"collection":"site_settings","field":"terms_of_use"}	\N	\N
138	168	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	{"id":"af52b75b-38ba-4a28-8b5a-0809b1456f54","hero_title":"Nous imaginons le numérique de demain.","hero_subtitle":"Pensé pour tous.","hero_description":"DOMMSOFT combine savoir-faire technique et créativité pour concevoir des produits numériques qui répondent à de vrais besoins.","hero_badge":"L'innovation au service de tous","cta_primary_text":"Découvrir nos solutions","cta_primary_url":"#products","cta_secondary_text":"Donnez vie à votre idée","cta_secondary_url":"/contact","social_twitter":"https://twitter.com/dommsoft","social_linkedin":"https://linkedin.com/company/dommsoft","social_github":"https://github.com/dommsoft","footer_newsletter_title":"Restez informé de nos nouveautés","footer_newsletter_description":"Recevez nos actualités produits, guides techniques et invitations événementielles directement dans votre boîte mail.","legal_mentions":"<h2>Éditeur du site</h2><p>DOMMSOFT<br>Société par actions simplifiée<br>Siège social : Cotonou, Bénin</p><h2>Directeur de la publication</h2><p>Le représentant légal de la société DOMMSOFT.</p><h2>Hébergement</h2><p>Ce site est hébergé par Vercel Inc.<br>440 N Barranca Ave #4133<br>Covina, CA 91723, États-Unis</p><h2>Propriété intellectuelle</h2><p>L'ensemble du contenu de ce site (textes, images, vidéos, logos, marques) est protégé par le droit de la propriété intellectuelle. Toute reproduction, représentation ou diffusion, totale ou partielle, du contenu de ce site sans autorisation préalable est interdite.</p><h2>Contact</h2><p>Pour toute question relative aux mentions légales, vous pouvez nous contacter à l'adresse : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>","privacy_policy":"<h2>Introduction</h2><p>DOMMSOFT s'engage à protéger la vie privée de ses utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons vos données personnelles.</p><h2>Données collectées</h2><p>Nous collectons les données suivantes :</p><ul><li>Données d'identification : nom, prénom, adresse email</li><li>Données de contact : numéro de téléphone, pays</li><li>Données de candidature : CV, lettre de motivation</li><li>Données de navigation : cookies, adresse IP</li></ul><h2>Finalités du traitement</h2><p>Vos données sont utilisées pour :</p><ul><li>Répondre à vos demandes de contact</li><li>Traiter vos candidatures</li><li>Vous envoyer notre newsletter (avec votre consentement)</li><li>Améliorer nos services</li></ul><h2>Durée de conservation</h2><p>Vos données sont conservées pendant une durée maximale de 3 ans à compter de votre dernier contact avec nous.</p><h2>Vos droits</h2><p>Conformément à la réglementation en vigueur, vous disposez des droits suivants : accès, rectification, suppression, opposition, limitation et portabilité de vos données. Pour exercer ces droits, contactez-nous à : <a href='mailto:privacy@dommsoft.com'>privacy@dommsoft.com</a></p>","terms_of_use":"<h2>Objet</h2><p>Les présentes conditions générales d'utilisation (CGU) régissent l'accès et l'utilisation du site web dommsoft.com.</p><h2>Accès au site</h2><p>L'accès au site est gratuit. Les frais d'accès et d'utilisation du réseau de télécommunication sont à la charge de l'utilisateur.</p><h2>Utilisation du site</h2><p>L'utilisateur s'engage à utiliser le site de manière conforme à sa destination et à ne pas porter atteinte à l'ordre public ni aux droits de tiers.</p><h2>Propriété intellectuelle</h2><p>Tous les éléments du site (textes, images, logos, code source) sont la propriété exclusive de DOMMSOFT ou de ses partenaires. Toute reproduction non autorisée constitue une contrefaçon.</p><h2>Responsabilité</h2><p>DOMMSOFT s'efforce de fournir des informations exactes et à jour. Toutefois, nous ne pouvons garantir l'exactitude, la complétude ou l'actualité des informations diffusées sur le site.</p><h2>Modification des CGU</h2><p>DOMMSOFT se réserve le droit de modifier les présentes CGU à tout moment. Les modifications prennent effet dès leur publication sur le site.</p><h2>Contact</h2><p>Pour toute question relative aux présentes CGU, contactez-nous à : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>"}	{"legal_mentions":"<h2>Éditeur du site</h2><p>DOMMSOFT<br>Société par actions simplifiée<br>Siège social : Cotonou, Bénin</p><h2>Directeur de la publication</h2><p>Le représentant légal de la société DOMMSOFT.</p><h2>Hébergement</h2><p>Ce site est hébergé par Vercel Inc.<br>440 N Barranca Ave #4133<br>Covina, CA 91723, États-Unis</p><h2>Propriété intellectuelle</h2><p>L'ensemble du contenu de ce site (textes, images, vidéos, logos, marques) est protégé par le droit de la propriété intellectuelle. Toute reproduction, représentation ou diffusion, totale ou partielle, du contenu de ce site sans autorisation préalable est interdite.</p><h2>Contact</h2><p>Pour toute question relative aux mentions légales, vous pouvez nous contacter à l'adresse : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>","privacy_policy":"<h2>Introduction</h2><p>DOMMSOFT s'engage à protéger la vie privée de ses utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons vos données personnelles.</p><h2>Données collectées</h2><p>Nous collectons les données suivantes :</p><ul><li>Données d'identification : nom, prénom, adresse email</li><li>Données de contact : numéro de téléphone, pays</li><li>Données de candidature : CV, lettre de motivation</li><li>Données de navigation : cookies, adresse IP</li></ul><h2>Finalités du traitement</h2><p>Vos données sont utilisées pour :</p><ul><li>Répondre à vos demandes de contact</li><li>Traiter vos candidatures</li><li>Vous envoyer notre newsletter (avec votre consentement)</li><li>Améliorer nos services</li></ul><h2>Durée de conservation</h2><p>Vos données sont conservées pendant une durée maximale de 3 ans à compter de votre dernier contact avec nous.</p><h2>Vos droits</h2><p>Conformément à la réglementation en vigueur, vous disposez des droits suivants : accès, rectification, suppression, opposition, limitation et portabilité de vos données. Pour exercer ces droits, contactez-nous à : <a href='mailto:privacy@dommsoft.com'>privacy@dommsoft.com</a></p>","terms_of_use":"<h2>Objet</h2><p>Les présentes conditions générales d'utilisation (CGU) régissent l'accès et l'utilisation du site web dommsoft.com.</p><h2>Accès au site</h2><p>L'accès au site est gratuit. Les frais d'accès et d'utilisation du réseau de télécommunication sont à la charge de l'utilisateur.</p><h2>Utilisation du site</h2><p>L'utilisateur s'engage à utiliser le site de manière conforme à sa destination et à ne pas porter atteinte à l'ordre public ni aux droits de tiers.</p><h2>Propriété intellectuelle</h2><p>Tous les éléments du site (textes, images, logos, code source) sont la propriété exclusive de DOMMSOFT ou de ses partenaires. Toute reproduction non autorisée constitue une contrefaçon.</p><h2>Responsabilité</h2><p>DOMMSOFT s'efforce de fournir des informations exactes et à jour. Toutefois, nous ne pouvons garantir l'exactitude, la complétude ou l'actualité des informations diffusées sur le site.</p><h2>Modification des CGU</h2><p>DOMMSOFT se réserve le droit de modifier les présentes CGU à tout moment. Les modifications prennent effet dès leur publication sur le site.</p><h2>Contact</h2><p>Pour toute question relative aux présentes CGU, contactez-nous à : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>"}	\N	\N
139	169	directus_collections	applications	{"collection":"applications","icon":"assignment_ind","note":null,"display_template":null,"hidden":false,"singleton":false,"translations":[{"language":"fr-FR","translation":"Candidatures"}],"archive_field":null,"archive_app_filter":true,"archive_value":null,"unarchive_value":null,"sort_field":null,"accountability":"all","color":null,"item_duplication_fields":null,"sort":null,"group":null,"collapse":"open","preview_url":null,"versioning":false}	{"translations":[{"language":"fr-FR","translation":"Candidatures"}]}	\N	\N
140	172	directus_files	79ce463c-8e10-4735-86d8-f1e159c5cbd0	{"title":"Dev Boost Guide Complet V2","filename_download":"DevBoost_Guide_Complet_V2.docx","type":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","storage":"local"}	{"title":"Dev Boost Guide Complet V2","filename_download":"DevBoost_Guide_Complet_V2.docx","type":"application/vnd.openxmlformats-officedocument.wordprocessingml.document","storage":"local"}	\N	\N
141	173	applications	98d36d5b-a158-4416-9c9c-d5f1863f2426	{"first_name":"Okalaon Marius","last_name":"Djenontin","email":"minhadjenotinmarius@gmail.com","phone":"+33650578737","country":"France","motivation":null,"job_title":"Développeur Full-Stack Senior","job_slug":"developpeur-fullstack-senior","cv":"79ce463c-8e10-4735-86d8-f1e159c5cbd0"}	{"first_name":"Okalaon Marius","last_name":"Djenontin","email":"minhadjenotinmarius@gmail.com","phone":"+33650578737","country":"France","motivation":null,"job_title":"Développeur Full-Stack Senior","job_slug":"developpeur-fullstack-senior","cv":"79ce463c-8e10-4735-86d8-f1e159c5cbd0"}	\N	\N
142	177	directus_fields	91	{"sort":14,"interface":"file-image","special":["file"],"collection":"products","field":"image"}	{"sort":14,"interface":"file-image","special":["file"],"collection":"products","field":"image"}	\N	\N
143	178	directus_fields	1	{"id":1,"collection":"products","field":"id","special":["uuid"],"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"id","sort":1,"group":null}	\N	\N
144	179	directus_fields	2	{"id":2,"collection":"products","field":"status","special":null,"interface":"select-dropdown","options":{"choices":[{"text":"Publié","value":"published"},{"text":"Brouillon","value":"draft"},{"text":"Bientôt","value":"coming_soon"},{"text":"Archivé","value":"archived"}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"status","sort":2,"group":null}	\N	\N
145	180	directus_fields	3	{"id":3,"collection":"products","field":"sort","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":true,"sort":3,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"sort","sort":3,"group":null}	\N	\N
146	181	directus_fields	4	{"id":4,"collection":"products","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":4,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"date_created","sort":4,"group":null}	\N	\N
147	182	directus_fields	5	{"id":5,"collection":"products","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":5,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"date_updated","sort":5,"group":null}	\N	\N
148	183	directus_fields	6	{"id":6,"collection":"products","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"half","translations":null,"note":"Nom du produit","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"name","sort":6,"group":null}	\N	\N
149	184	directus_fields	7	{"id":7,"collection":"products","field":"slug","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"half","translations":null,"note":"URL du produit (ex: dommpay)","conditions":null,"required":true,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"slug","sort":7,"group":null}	\N	\N
150	185	directus_fields	8	{"id":8,"collection":"products","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":"Description courte","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"description","sort":8,"group":null}	\N	\N
151	186	directus_fields	9	{"id":9,"collection":"products","field":"content","special":null,"interface":"input-rich-text-html","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":"Contenu détaillé de la page produit","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"content","sort":9,"group":null}	\N	\N
152	187	directus_fields	91	{"id":91,"collection":"products","field":"image","special":["file"],"interface":"file-image","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"image","sort":10,"group":null}	\N	\N
153	188	directus_fields	10	{"id":10,"collection":"products","field":"icon","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":11,"width":"half","translations":null,"note":"Nom de l icône Lucide (ex: Wallet, Cloud)","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"icon","sort":11,"group":null}	\N	\N
154	189	directus_fields	11	{"id":11,"collection":"products","field":"color","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":12,"width":"half","translations":null,"note":"Couleur CSS (ex: text-emerald-500)","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"color","sort":12,"group":null}	\N	\N
155	190	directus_fields	59	{"id":59,"collection":"products","field":"features","special":["cast-json"],"interface":"tags","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":13,"width":"full","translations":null,"note":"Liste de fonctionnalités clés","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"features","sort":13,"group":null}	\N	\N
156	191	directus_files	2a43a3f1-63dd-41f1-8042-d63451eaad23	{"title":"Capture D’écran 2026 02 04 À 23.26.13","filename_download":"Capture d’écran 2026-02-04 à 23.26.13.png","type":"image/png","storage":"local"}	{"title":"Capture D’écran 2026 02 04 À 23.26.13","filename_download":"Capture d’écran 2026-02-04 à 23.26.13.png","type":"image/png","storage":"local"}	\N	\N
157	192	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-04T22:36:06.822Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23"}	{"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","date_updated":"2026-02-04T22:36:06.822Z"}	\N	\N
158	193	directus_files	752de803-5294-4947-930b-5dc379152447	{"title":"Capture D’écran 2026 01 08 À 00.05.44","filename_download":"Capture d’écran 2026-01-08 à 00.05.44.png","type":"image/png","storage":"local"}	{"title":"Capture D’écran 2026 01 08 À 00.05.44","filename_download":"Capture d’écran 2026-01-08 à 00.05.44.png","type":"image/png","storage":"local"}	\N	\N
159	194	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"id":"c5ce8492-a63a-4f34-a099-8368179a57ec","status":"published","sort":3,"date_created":"2026-02-04T17:14:10.060Z","date_updated":"2026-02-04T22:36:29.227Z","name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","content":null,"icon":"Users","color":"text-violet-500","features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"],"image":"752de803-5294-4947-930b-5dc379152447"}	{"image":"752de803-5294-4947-930b-5dc379152447","date_updated":"2026-02-04T22:36:29.227Z"}	\N	\N
160	195	blog_posts	5b444ec8-5a61-4abe-ad30-bd0af5916dd3	{"id":"5b444ec8-5a61-4abe-ad30-bd0af5916dd3","status":"published","sort":1,"date_created":"2026-02-04T17:52:23.544Z","date_updated":"2026-02-04T22:55:36.295Z","title":"Comment le paiement mobile transforme le commerce en Afrique","slug":"paiement-mobile-commerce-afrique","excerpt":"Le paiement mobile connaît une croissance exponentielle. Découvrez comment cette révolution redéfinit les échanges commerciaux et ouvre de nouvelles opportunités.","content":"<p><img src=\\"http://localhost:8055/assets/752de803-5294-4947-930b-5dc379152447.png?width=2880&amp;height=1800\\" alt=\\"Capture D&rsquo;écran 2026 01 08 À 00.05.44\\"></p>\\n<p>Le paiement mobile est en train de transformer radicalement la mani&egrave;re dont les transactions commerciales sont effectu&eacute;es. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une r&eacute;f&eacute;rence mondiale.</p>\\n<h2>Une adoption sans pr&eacute;c&eacute;dent</h2>\\n<p>Le mobile money s'est impos&eacute; comme le moyen de paiement digital de r&eacute;f&eacute;rence dans de nombreux march&eacute;s. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connect&eacute;e, un faible taux de bancarisation traditionnelle, et des solutions adapt&eacute;es aux r&eacute;alit&eacute;s locales.</p>\\n<h2>L'impact sur le commerce</h2>\\n<p>Les commer&ccedil;ants b&eacute;n&eacute;ficient d&eacute;sormais d'outils qui leur permettent d'accepter des paiements de mani&egrave;re s&eacute;curis&eacute;e et instantan&eacute;e. Cette digitalisation des &eacute;changes favorise la tra&ccedil;abilit&eacute;, r&eacute;duit les risques li&eacute;s au cash et ouvre l'acc&egrave;s &agrave; de nouveaux march&eacute;s.</p>\\n<h2>DommPay au c&oelig;ur de cette transformation</h2>\\n<p>Chez DOMMSOFT, nous avons con&ccedil;u DommPay pour r&eacute;pondre pr&eacute;cis&eacute;ment &agrave; ces enjeux. Notre solution int&egrave;gre les principaux op&eacute;rateurs mobile money et offre une exp&eacute;rience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>","date_published":"2026-01-28T10:00:00.000Z","author":"Équipe DOMMSOFT","tags":["Paiement","Mobile Money","Fintech"],"cover_image":"55a318cc-ae6b-48a6-9865-3bbc83f20982"}	{"content":"<p><img src=\\"http://localhost:8055/assets/752de803-5294-4947-930b-5dc379152447.png?width=2880&amp;height=1800\\" alt=\\"Capture D&rsquo;écran 2026 01 08 À 00.05.44\\"></p>\\n<p>Le paiement mobile est en train de transformer radicalement la mani&egrave;re dont les transactions commerciales sont effectu&eacute;es. Avec plus de 600 millions de comptes mobile money actifs, cette technologie s'impose comme une r&eacute;f&eacute;rence mondiale.</p>\\n<h2>Une adoption sans pr&eacute;c&eacute;dent</h2>\\n<p>Le mobile money s'est impos&eacute; comme le moyen de paiement digital de r&eacute;f&eacute;rence dans de nombreux march&eacute;s. Cette adoption rapide s'explique par plusieurs facteurs : une population jeune et connect&eacute;e, un faible taux de bancarisation traditionnelle, et des solutions adapt&eacute;es aux r&eacute;alit&eacute;s locales.</p>\\n<h2>L'impact sur le commerce</h2>\\n<p>Les commer&ccedil;ants b&eacute;n&eacute;ficient d&eacute;sormais d'outils qui leur permettent d'accepter des paiements de mani&egrave;re s&eacute;curis&eacute;e et instantan&eacute;e. Cette digitalisation des &eacute;changes favorise la tra&ccedil;abilit&eacute;, r&eacute;duit les risques li&eacute;s au cash et ouvre l'acc&egrave;s &agrave; de nouveaux march&eacute;s.</p>\\n<h2>DommPay au c&oelig;ur de cette transformation</h2>\\n<p>Chez DOMMSOFT, nous avons con&ccedil;u DommPay pour r&eacute;pondre pr&eacute;cis&eacute;ment &agrave; ces enjeux. Notre solution int&egrave;gre les principaux op&eacute;rateurs mobile money et offre une exp&eacute;rience de paiement fluide, aussi bien pour les marchands que pour les consommateurs.</p>","date_updated":"2026-02-04T22:55:36.295Z"}	\N	\N
161	200	directus_flows	3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	{"name":"Notification Nouveau Contact","icon":"mail","color":"#2c85c5","description":"Envoie un email à l admin quand un nouveau message de contact est reçu","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contacts"]}}	{"name":"Notification Nouveau Contact","icon":"mail","color":"#2c85c5","description":"Envoie un email à l admin quand un nouveau message de contact est reçu","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contacts"]}}	\N	\N
162	202	directus_operations	54dced3b-2149-4e47-9470-9d43058ad9dd	{"name":"Envoyer Email Admin","key":"send_email_admin","type":"mail","position_x":19,"position_y":1,"flow":"3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6","options":{"to":"minhadjenontin@gmail.com","subject":"🔔 Nouveau message de contact - DOMMSOFT","body":"<h2>Nouveau message reçu</h2><p><strong>De:</strong> {{$trigger.payload.name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Sujet:</strong> {{$trigger.payload.subject}}</p><p><strong>Message:</strong></p><p>{{$trigger.payload.message}}</p><hr><p><small>Reçu le {{$trigger.payload.date_created}}</small></p>","type":"text/html"}}	{"name":"Envoyer Email Admin","key":"send_email_admin","type":"mail","position_x":19,"position_y":1,"flow":"3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6","options":{"to":"minhadjenontin@gmail.com","subject":"🔔 Nouveau message de contact - DOMMSOFT","body":"<h2>Nouveau message reçu</h2><p><strong>De:</strong> {{$trigger.payload.name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Sujet:</strong> {{$trigger.payload.subject}}</p><p><strong>Message:</strong></p><p>{{$trigger.payload.message}}</p><hr><p><small>Reçu le {{$trigger.payload.date_created}}</small></p>","type":"text/html"}}	\N	\N
163	204	directus_flows	3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6	{"id":"3c41191a-0ccb-45d7-b8cf-88af1b0ad1d6","name":"Notification Nouveau Contact","icon":"mail","color":"#2c85c5","description":"Envoie un email à l admin quand un nouveau message de contact est reçu","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["contacts"]},"operation":"54dced3b-2149-4e47-9470-9d43058ad9dd","date_created":"2026-02-05T16:00:33.043Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["54dced3b-2149-4e47-9470-9d43058ad9dd"]}	{"operation":"54dced3b-2149-4e47-9470-9d43058ad9dd"}	\N	\N
164	206	directus_flows	47382480-b09f-4b82-bc6d-ba32ae593bc7	{"name":"Bienvenue Newsletter","icon":"celebration","color":"#10b981","description":"Envoie un email de bienvenue aux nouveaux abonnés newsletter","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["newsletter_subscribers"]}}	{"name":"Bienvenue Newsletter","icon":"celebration","color":"#10b981","description":"Envoie un email de bienvenue aux nouveaux abonnés newsletter","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["newsletter_subscribers"]}}	\N	\N
165	210	directus_operations	1da568e1-d35b-4424-8d0b-7a336e99bb06	{"name":"Email Bienvenue","key":"welcome_email","type":"mail","position_x":19,"position_y":1,"flow":"47382480-b09f-4b82-bc6d-ba32ae593bc7","options":{"to":"{{$trigger.payload.email}}","subject":"Bienvenue dans la newsletter DOMMSOFT!","body":"<h1>Bienvenue chez DOMMSOFT!</h1><p>Merci pour votre inscription.</p><p>L'equipe DOMMSOFT</p>","type":"text/html"}}	{"name":"Email Bienvenue","key":"welcome_email","type":"mail","position_x":19,"position_y":1,"flow":"47382480-b09f-4b82-bc6d-ba32ae593bc7","options":{"to":"{{$trigger.payload.email}}","subject":"Bienvenue dans la newsletter DOMMSOFT!","body":"<h1>Bienvenue chez DOMMSOFT!</h1><p>Merci pour votre inscription.</p><p>L'equipe DOMMSOFT</p>","type":"text/html"}}	\N	\N
166	211	directus_flows	47382480-b09f-4b82-bc6d-ba32ae593bc7	{"id":"47382480-b09f-4b82-bc6d-ba32ae593bc7","name":"Bienvenue Newsletter","icon":"celebration","color":"#10b981","description":"Envoie un email de bienvenue aux nouveaux abonnés newsletter","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["newsletter_subscribers"]},"operation":"1da568e1-d35b-4424-8d0b-7a336e99bb06","date_created":"2026-02-05T16:01:12.787Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["1da568e1-d35b-4424-8d0b-7a336e99bb06"]}	{"operation":"1da568e1-d35b-4424-8d0b-7a336e99bb06"}	\N	\N
167	213	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	{"name":"Notification Nouvelle Candidature","icon":"assignment_ind","color":"#8b5cf6","description":"Notifie l'admin quand une nouvelle candidature est recue","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["applications"]}}	{"name":"Notification Nouvelle Candidature","icon":"assignment_ind","color":"#8b5cf6","description":"Notifie l'admin quand une nouvelle candidature est recue","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["applications"]}}	\N	\N
168	214	directus_operations	ea77d55b-08c4-4213-abda-0e07d4cdef1c	{"name":"Notifier Admin Candidature","key":"notify_application","type":"mail","position_x":19,"position_y":1,"flow":"d1eb8f40-8120-4a24-8752-ac80817255a3","options":{"to":"minhadjenontin@gmail.com","subject":"Nouvelle candidature recue - DOMMSOFT","body":"<h2>Nouvelle candidature!</h2><p><strong>Candidat:</strong> {{$trigger.payload.first_name}} {{$trigger.payload.last_name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Poste:</strong> {{$trigger.payload.position}}</p><p>Connectez-vous a Directus pour voir le CV et les details.</p>","type":"text/html"}}	{"name":"Notifier Admin Candidature","key":"notify_application","type":"mail","position_x":19,"position_y":1,"flow":"d1eb8f40-8120-4a24-8752-ac80817255a3","options":{"to":"minhadjenontin@gmail.com","subject":"Nouvelle candidature recue - DOMMSOFT","body":"<h2>Nouvelle candidature!</h2><p><strong>Candidat:</strong> {{$trigger.payload.first_name}} {{$trigger.payload.last_name}}</p><p><strong>Email:</strong> {{$trigger.payload.email}}</p><p><strong>Poste:</strong> {{$trigger.payload.position}}</p><p>Connectez-vous a Directus pour voir le CV et les details.</p>","type":"text/html"}}	\N	\N
169	215	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	{"id":"d1eb8f40-8120-4a24-8752-ac80817255a3","name":"Notification Nouvelle Candidature","icon":"assignment_ind","color":"#8b5cf6","description":"Notifie l'admin quand une nouvelle candidature est recue","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.create"],"collections":["applications"]},"operation":"ea77d55b-08c4-4213-abda-0e07d4cdef1c","date_created":"2026-02-05T16:02:00.698Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["ea77d55b-08c4-4213-abda-0e07d4cdef1c"]}	{"operation":"ea77d55b-08c4-4213-abda-0e07d4cdef1c"}	\N	\N
170	221	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":"/* Cache la sidebar sur job_offers */\\n.module-bar + div:has([href*=\\"/job_offers\\"]) aside.sidebar { display: none !important; }\\n\\n/* Méthode alternative via attribut data */\\n[data-collection=\\"job_offers\\"] .sidebar-detail-group { display: none !important; }","storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"fr-FR","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"custom_css":"/* Cache la sidebar sur job_offers */\\n.module-bar + div:has([href*=\\"/job_offers\\"]) aside.sidebar { display: none !important; }\\n\\n/* Méthode alternative via attribut data */\\n[data-collection=\\"job_offers\\"] .sidebar-detail-group { display: none !important; }"}	\N	\N
179	243	directus_operations	8773f070-f588-4963-a514-2dde2582186f	{"name":"Lire la candidature","key":"read_application","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":"20001c38-f49a-4857-9cd5-287ba6461c4d","reject":null}	{"name":"Lire la candidature","key":"read_application","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":"20001c38-f49a-4857-9cd5-287ba6461c4d","reject":null}	\N	\N
171	223	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":"/* ========================================\\n   Cache la sidebar sur Job Offers\\n   ======================================== */\\n\\n/* Quand l'URL contient job_offers - moderne avec :has() */\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .v-workspace aside,\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .sidebar-detail-container,\\nbody:has(a[href*=\\"/content/job_offers/\\"]) [class*=\\"sidebar-detail\\"] {\\n  display: none !important;\\n}\\n\\n/* Target via data attributes Directus */\\n.item-page[data-collection=\\"job_offers\\"] .sidebar-detail-container,\\n[data-collection=\\"job_offers\\"] aside[class*=\\"sidebar\\"],\\n.collection-content-job_offers aside {\\n  display: none !important;\\n}\\n\\n/* Élargir le contenu principal quand sidebar cachée */\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .content {\\n  max-width: 100% !important;\\n}","storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"fr-FR","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"custom_css":"/* ========================================\\n   Cache la sidebar sur Job Offers\\n   ======================================== */\\n\\n/* Quand l'URL contient job_offers - moderne avec :has() */\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .v-workspace aside,\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .sidebar-detail-container,\\nbody:has(a[href*=\\"/content/job_offers/\\"]) [class*=\\"sidebar-detail\\"] {\\n  display: none !important;\\n}\\n\\n/* Target via data attributes Directus */\\n.item-page[data-collection=\\"job_offers\\"] .sidebar-detail-container,\\n[data-collection=\\"job_offers\\"] aside[class*=\\"sidebar\\"],\\n.collection-content-job_offers aside {\\n  display: none !important;\\n}\\n\\n/* Élargir le contenu principal quand sidebar cachée */\\nbody:has(a[href*=\\"/content/job_offers/\\"]) .content {\\n  max-width: 100% !important;\\n}"}	\N	\N
172	225	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":"/* Cache TOUTE la sidebar droite sur job_offers */\\n\\n/* Sélecteur large - cible aside et panels à droite */\\n.router-link-active[href*=\\"job_offers\\"] ~ aside,\\n[href*=\\"/content/job_offers\\"].router-link-active ~ aside,\\nmain:has([href*=\\"job_offers\\"].router-link-active) aside,\\n.module-content:has([href*=\\"job_offers\\"]) aside,\\n#main-content:has([href*=\\"job_offers\\"]) aside {\\n  display: none !important;\\n  width: 0 !important;\\n}\\n\\n/* Directus v10+ structure */\\n.private-view:has(.router-link-active[href*=\\"job_offers\\"]) .sidebar-detail,\\n.private-view:has(.router-link-active[href*=\\"job_offers\\"]) [class*=\\"sidebar\\"],\\n.private-view:has([href*=\\"job_offers\\"].router-link-exact-active) aside {\\n  display: none !important;\\n}\\n\\n/* Ultra générique - via URL check */\\nbody:has([href*=\\"job_offers\\"].router-link-exact-active) aside:last-of-type {\\n  display: none !important;\\n}","storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"fr-FR","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"custom_css":"/* Cache TOUTE la sidebar droite sur job_offers */\\n\\n/* Sélecteur large - cible aside et panels à droite */\\n.router-link-active[href*=\\"job_offers\\"] ~ aside,\\n[href*=\\"/content/job_offers\\"].router-link-active ~ aside,\\nmain:has([href*=\\"job_offers\\"].router-link-active) aside,\\n.module-content:has([href*=\\"job_offers\\"]) aside,\\n#main-content:has([href*=\\"job_offers\\"]) aside {\\n  display: none !important;\\n  width: 0 !important;\\n}\\n\\n/* Directus v10+ structure */\\n.private-view:has(.router-link-active[href*=\\"job_offers\\"]) .sidebar-detail,\\n.private-view:has(.router-link-active[href*=\\"job_offers\\"]) [class*=\\"sidebar\\"],\\n.private-view:has([href*=\\"job_offers\\"].router-link-exact-active) aside {\\n  display: none !important;\\n}\\n\\n/* Ultra générique - via URL check */\\nbody:has([href*=\\"job_offers\\"].router-link-exact-active) aside:last-of-type {\\n  display: none !important;\\n}"}	\N	\N
173	226	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":"","storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"fr-FR","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019c2996-e6fa-75fb-8060-fe2e4979e3d6","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"minhadjenontin@gmail.com","project_usage":"commercial","org_name":"DOMMSOFT","product_updates":false,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"custom_css":""}	\N	\N
174	227	site_settings	af52b75b-38ba-4a28-8b5a-0809b1456f54	{"id":"af52b75b-38ba-4a28-8b5a-0809b1456f54","hero_title":"Nous imaginons le numérique de demain.dsds","hero_subtitle":"Pensé pour tous.","hero_description":"DOMMSOFT combine savoir-faire technique et créativité pour concevoir des produits numériques qui répondent à de vrais besoins.","hero_badge":"L'innovation au service de tous","cta_primary_text":"Découvrir nos solutions","cta_primary_url":"#products","cta_secondary_text":"Donnez vie à votre idée","cta_secondary_url":"/contact","social_twitter":"https://twitter.com/dommsoft","social_linkedin":"https://linkedin.com/company/dommsoft","social_github":"https://github.com/dommsoft","footer_newsletter_title":"Restez informé de nos nouveautés","footer_newsletter_description":"Recevez nos actualités produits, guides techniques et invitations événementielles directement dans votre boîte mail.","legal_mentions":"<h2>Éditeur du site</h2><p>DOMMSOFT<br>Société par actions simplifiée<br>Siège social : Cotonou, Bénin</p><h2>Directeur de la publication</h2><p>Le représentant légal de la société DOMMSOFT.</p><h2>Hébergement</h2><p>Ce site est hébergé par Vercel Inc.<br>440 N Barranca Ave #4133<br>Covina, CA 91723, États-Unis</p><h2>Propriété intellectuelle</h2><p>L'ensemble du contenu de ce site (textes, images, vidéos, logos, marques) est protégé par le droit de la propriété intellectuelle. Toute reproduction, représentation ou diffusion, totale ou partielle, du contenu de ce site sans autorisation préalable est interdite.</p><h2>Contact</h2><p>Pour toute question relative aux mentions légales, vous pouvez nous contacter à l'adresse : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>","privacy_policy":"<h2>Introduction</h2><p>DOMMSOFT s'engage à protéger la vie privée de ses utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons vos données personnelles.</p><h2>Données collectées</h2><p>Nous collectons les données suivantes :</p><ul><li>Données d'identification : nom, prénom, adresse email</li><li>Données de contact : numéro de téléphone, pays</li><li>Données de candidature : CV, lettre de motivation</li><li>Données de navigation : cookies, adresse IP</li></ul><h2>Finalités du traitement</h2><p>Vos données sont utilisées pour :</p><ul><li>Répondre à vos demandes de contact</li><li>Traiter vos candidatures</li><li>Vous envoyer notre newsletter (avec votre consentement)</li><li>Améliorer nos services</li></ul><h2>Durée de conservation</h2><p>Vos données sont conservées pendant une durée maximale de 3 ans à compter de votre dernier contact avec nous.</p><h2>Vos droits</h2><p>Conformément à la réglementation en vigueur, vous disposez des droits suivants : accès, rectification, suppression, opposition, limitation et portabilité de vos données. Pour exercer ces droits, contactez-nous à : <a href='mailto:privacy@dommsoft.com'>privacy@dommsoft.com</a></p>","terms_of_use":"<h2>Objet</h2><p>Les présentes conditions générales d'utilisation (CGU) régissent l'accès et l'utilisation du site web dommsoft.com.</p><h2>Accès au site</h2><p>L'accès au site est gratuit. Les frais d'accès et d'utilisation du réseau de télécommunication sont à la charge de l'utilisateur.</p><h2>Utilisation du site</h2><p>L'utilisateur s'engage à utiliser le site de manière conforme à sa destination et à ne pas porter atteinte à l'ordre public ni aux droits de tiers.</p><h2>Propriété intellectuelle</h2><p>Tous les éléments du site (textes, images, logos, code source) sont la propriété exclusive de DOMMSOFT ou de ses partenaires. Toute reproduction non autorisée constitue une contrefaçon.</p><h2>Responsabilité</h2><p>DOMMSOFT s'efforce de fournir des informations exactes et à jour. Toutefois, nous ne pouvons garantir l'exactitude, la complétude ou l'actualité des informations diffusées sur le site.</p><h2>Modification des CGU</h2><p>DOMMSOFT se réserve le droit de modifier les présentes CGU à tout moment. Les modifications prennent effet dès leur publication sur le site.</p><h2>Contact</h2><p>Pour toute question relative aux présentes CGU, contactez-nous à : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>"}	{"hero_title":"Nous imaginons le numérique de demain.dsds"}	\N	\N
175	234	directus_flows	dffa8e0b-6c1b-4115-a8c0-a7ae476d908f	{"name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	{"name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	\N	\N
176	235	directus_operations	70ce8f80-3e4a-407d-8f4f-090cbce2df2d	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":"{{read_application.email}}","subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_application.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_application.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"dffa8e0b-6c1b-4115-a8c0-a7ae476d908f","resolve":null,"reject":null}	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":"{{read_application.email}}","subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_application.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_application.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"dffa8e0b-6c1b-4115-a8c0-a7ae476d908f","resolve":null,"reject":null}	\N	\N
177	241	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	{"name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	{"name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	\N	\N
234	346	directus_fields	97	{"sort":2,"interface":"input","hidden":true,"width":"half","field":"sort","collection":"stats"}	{"sort":2,"interface":"input","hidden":true,"width":"half","field":"sort","collection":"stats"}	\N	\N
178	242	directus_operations	20001c38-f49a-4857-9cd5-287ba6461c4d	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_application.email}}"],"subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_application.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_application.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":null,"reject":null}	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_application.email}}"],"subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_application.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_application.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":null,"reject":null}	\N	\N
181	245	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	{"id":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]},"operation":"a9821a29-f132-420d-bf7e-788e88fe5a81","date_created":"2026-02-06T09:12:31.632Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["20001c38-f49a-4857-9cd5-287ba6461c4d","8773f070-f588-4963-a514-2dde2582186f","a9821a29-f132-420d-bf7e-788e88fe5a81"]}	{"operation":"a9821a29-f132-420d-bf7e-788e88fe5a81"}	\N	\N
183	247	directus_operations	caf1a645-4b29-4710-97f0-3c4c5095e76b	{"name":"Envoyer email refus","key":"send_refused_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_application_refused.email}}"],"subject":"Suite à votre candidature chez DOMMSOFT","body":"<h2>Bonjour {{read_application_refused.first_name}},</h2><p>Nous vous remercions pour l'intérêt que vous portez à DOMMSOFT et pour le temps consacré à votre candidature pour le poste <strong>\\"{{read_application_refused.job_title}}\\"</strong>.</p><p>Après étude attentive de votre dossier, nous avons le regret de vous informer que votre candidature n'a pas été retenue pour ce poste.</p><p>Nous conservons votre profil et ne manquerons pas de vous recontacter si une opportunité correspondant à votre profil se présente.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":null,"reject":null}	{"name":"Envoyer email refus","key":"send_refused_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_application_refused.email}}"],"subject":"Suite à votre candidature chez DOMMSOFT","body":"<h2>Bonjour {{read_application_refused.first_name}},</h2><p>Nous vous remercions pour l'intérêt que vous portez à DOMMSOFT et pour le temps consacré à votre candidature pour le poste <strong>\\"{{read_application_refused.job_title}}\\"</strong>.</p><p>Après étude attentive de votre dossier, nous avons le regret de vous informer que votre candidature n'a pas été retenue pour ce poste.</p><p>Nous conservons votre profil et ne manquerons pas de vous recontacter si une opportunité correspondant à votre profil se présente.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":null,"reject":null}	\N	\N
185	249	directus_operations	092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3	{"name":"Vérifier statut = refused","key":"check_refused","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"refused"}}}}},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":"cf5010c8-58cb-4e9b-b85e-491007a045ab","reject":null}	{"name":"Vérifier statut = refused","key":"check_refused","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"refused"}}}}},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":"cf5010c8-58cb-4e9b-b85e-491007a045ab","reject":null}	\N	\N
180	244	directus_operations	a9821a29-f132-420d-bf7e-788e88fe5a81	{"name":"Vérifier statut = accepted","key":"check_accepted","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"accepted"}}}}},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":"8773f070-f588-4963-a514-2dde2582186f","reject":null}	{"name":"Vérifier statut = accepted","key":"check_accepted","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"accepted"}}}}},"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","resolve":"8773f070-f588-4963-a514-2dde2582186f","reject":null}	\N	\N
182	246	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	{"name":"Candidature Refusée","icon":"cancel","color":"#ef4444","description":"Envoie un email au candidat quand sa candidature est refusée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	{"name":"Candidature Refusée","icon":"cancel","color":"#ef4444","description":"Envoie un email au candidat quand sa candidature est refusée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]}}	\N	\N
184	248	directus_operations	cf5010c8-58cb-4e9b-b85e-491007a045ab	{"name":"Lire la candidature","key":"read_application_refused","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":"caf1a645-4b29-4710-97f0-3c4c5095e76b","reject":null}	{"name":"Lire la candidature","key":"read_application_refused","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","resolve":"caf1a645-4b29-4710-97f0-3c4c5095e76b","reject":null}	\N	\N
186	250	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	{"id":"716503d1-1167-4a3c-9876-32c2efa22ae2","name":"Candidature Refusée","icon":"cancel","color":"#ef4444","description":"Envoie un email au candidat quand sa candidature est refusée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]},"operation":"092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3","date_created":"2026-02-06T09:12:31.927Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3","caf1a645-4b29-4710-97f0-3c4c5095e76b","cf5010c8-58cb-4e9b-b85e-491007a045ab"]}	{"operation":"092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3"}	\N	\N
187	254	directus_flows	6350ae24-b149-4f1f-a67f-0d48a1fa0cb4	{"id":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","name":"Candidature Acceptée","icon":"check_circle","color":"#22c55e","description":"Envoie un email au candidat quand sa candidature est acceptée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]},"operation":null,"date_created":"2026-02-06T09:12:31.632Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["20001c38-f49a-4857-9cd5-287ba6461c4d","8773f070-f588-4963-a514-2dde2582186f","a9821a29-f132-420d-bf7e-788e88fe5a81"]}	{"operation":null}	\N	\N
188	255	directus_operations	8773f070-f588-4963-a514-2dde2582186f	{"id":"8773f070-f588-4963-a514-2dde2582186f","name":"Lire la candidature","key":"read_application","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"resolve":null,"reject":null,"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","date_created":"2026-02-06T09:12:31.689Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6"}	{"resolve":null,"reject":null}	\N	\N
189	256	directus_operations	a9821a29-f132-420d-bf7e-788e88fe5a81	{"id":"a9821a29-f132-420d-bf7e-788e88fe5a81","name":"Vérifier statut = accepted","key":"check_accepted","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"accepted"}}}}},"resolve":null,"reject":null,"flow":"6350ae24-b149-4f1f-a67f-0d48a1fa0cb4","date_created":"2026-02-06T09:12:31.705Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6"}	{"resolve":null,"reject":null}	\N	\N
190	261	directus_flows	716503d1-1167-4a3c-9876-32c2efa22ae2	{"id":"716503d1-1167-4a3c-9876-32c2efa22ae2","name":"Candidature Refusée","icon":"cancel","color":"#ef4444","description":"Envoie un email au candidat quand sa candidature est refusée","status":"active","trigger":"event","accountability":"all","options":{"type":"action","scope":["items.update"],"collections":["applications"]},"operation":null,"date_created":"2026-02-06T09:12:31.927Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3","caf1a645-4b29-4710-97f0-3c4c5095e76b","cf5010c8-58cb-4e9b-b85e-491007a045ab"]}	{"operation":null}	\N	\N
191	262	directus_operations	092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3	{"id":"092d9c9a-47ca-4d79-9a4a-366dd7e2dcd3","name":"Vérifier statut = refused","key":"check_refused","type":"condition","position_x":19,"position_y":1,"options":{"filter":{"$trigger":{"payload":{"status":{"_eq":"refused"}}}}},"resolve":null,"reject":null,"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","date_created":"2026-02-06T09:12:32.067Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6"}	{"resolve":null,"reject":null}	\N	\N
192	263	directus_operations	cf5010c8-58cb-4e9b-b85e-491007a045ab	{"id":"cf5010c8-58cb-4e9b-b85e-491007a045ab","name":"Lire la candidature","key":"read_application_refused","type":"item-read","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.keys[0]}}"},"resolve":null,"reject":null,"flow":"716503d1-1167-4a3c-9876-32c2efa22ae2","date_created":"2026-02-06T09:12:32.048Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6"}	{"resolve":null,"reject":null}	\N	\N
193	268	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	{"name":"Accepter la candidature","icon":"check_circle","color":"#22c55e","description":"Bouton pour accepter une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous accepter cette candidature ? Un email sera envoyé au candidat."}}	{"name":"Accepter la candidature","icon":"check_circle","color":"#22c55e","description":"Bouton pour accepter une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous accepter cette candidature ? Un email sera envoyé au candidat."}}	\N	\N
195	270	directus_operations	d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa	{"name":"Marquer comme acceptée","key":"update_status_accepted","type":"item-update","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"accepted"}},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":"a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f","reject":null}	{"name":"Marquer comme acceptée","key":"update_status_accepted","type":"item-update","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"accepted"}},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":"a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f","reject":null}	\N	\N
194	269	directus_operations	a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_candidature.email}}"],"subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_candidature.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_candidature.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":null,"reject":null}	{"name":"Envoyer email acceptation","key":"send_accepted_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_candidature.email}}"],"subject":"Votre candidature chez DOMMSOFT a été retenue !","body":"<h2>Félicitations {{read_candidature.first_name}} !</h2><p>Nous avons le plaisir de vous informer que votre candidature pour le poste <strong>\\"{{read_candidature.job_title}}\\"</strong> a été retenue.</p><p>Notre équipe vous contactera très prochainement pour convenir d'un entretien.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":null,"reject":null}	\N	\N
196	271	directus_operations	3020d7db-904d-4d59-b756-e8194e509185	{"name":"Lire la candidature","key":"read_candidature","type":"item-read","position_x":19,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}"},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":"d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa","reject":null}	{"name":"Lire la candidature","key":"read_candidature","type":"item-read","position_x":19,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}"},"flow":"012fcd04-b4e2-482b-afdd-ec39ea068e89","resolve":"d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa","reject":null}	\N	\N
197	272	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	{"id":"012fcd04-b4e2-482b-afdd-ec39ea068e89","name":"Accepter la candidature","icon":"check_circle","color":"#22c55e","description":"Bouton pour accepter une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous accepter cette candidature ? Un email sera envoyé au candidat."},"operation":"3020d7db-904d-4d59-b756-e8194e509185","date_created":"2026-02-06T09:15:55.274Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["3020d7db-904d-4d59-b756-e8194e509185","a9c9d335-c727-4c2c-9cb5-3582b7e9dc4f","d7f05d7a-7baa-4f3c-8cd0-6b78829dabaa"]}	{"operation":"3020d7db-904d-4d59-b756-e8194e509185"}	\N	\N
200	275	directus_operations	b3b957d3-1529-4c1b-aa52-a84fd489e964	{"name":"Marquer comme refusée","key":"update_status_refused","type":"item-update","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"refused"}},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":"b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a","reject":null}	{"name":"Marquer comme refusée","key":"update_status_refused","type":"item-update","position_x":28,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}","payload":{"status":"refused"}},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":"b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a","reject":null}	\N	\N
201	276	directus_operations	fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92	{"name":"Lire la candidature","key":"read_candidature_refus","type":"item-read","position_x":19,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}"},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":"b3b957d3-1529-4c1b-aa52-a84fd489e964","reject":null}	{"name":"Lire la candidature","key":"read_candidature_refus","type":"item-read","position_x":19,"position_y":1,"options":{"collection":"applications","key":"{{$trigger.body[0]}}"},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":"b3b957d3-1529-4c1b-aa52-a84fd489e964","reject":null}	\N	\N
205	281	directus_flows	d1eb8f40-8120-4a24-8752-ac80817255a3	{"steps":[{"operation":"ea77d55b-08c4-4213-abda-0e07d4cdef1c","key":"notify_application","status":"resolve","options":{"to":"minhadjenontin@gmail.com","subject":"Nouvelle candidature recue - DOMMSOFT","body":"<h2>Nouvelle candidature!</h2><p><strong>Candidat:</strong> Jean Dupont</p><p><strong>Email:</strong> minhadjenontin@gmail.com</p><p><strong>Poste:</strong> undefined</p><p>Connectez-vous a Directus pour voir le CV et les details.</p>","type":"text/html"}}],"data":{"$trigger":{"event":"applications.items.create","payload":{"status":"pending","first_name":"Jean","last_name":"Dupont","email":"minhadjenontin@gmail.com","phone":"+33612345678","country":"France","job_title":"Développeur Full Stack","job_slug":"developpeur-fullstack","motivation":"Candidature test pour vérifier les flux Directus."},"key":"0508625e-ac25-42d4-8fe8-1bdeb4c4d36f","collection":"applications"},"$last":null,"$accountability":{"role":"988ce776-97f5-4b0a-a973-976491e7ebca","user":"c0731d51-a5b8-49a9-901f-d0de152a48e6","roles":["988ce776-97f5-4b0a-a973-976491e7ebca"],"admin":true,"app":true,"ip":"192.168.65.1","userAgent":"curl/8.7.1"},"$env":{},"notify_application":null}}	\N	\N	\N
206	284	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	{"id":"0508625e-ac25-42d4-8fe8-1bdeb4c4d36f","status":"accepted","date_created":"2026-02-06T09:22:14.279Z","first_name":"Jean","last_name":"Dupont","email":"minhadjenontin@gmail.com","phone":"+33612345678","country":"France","job_title":"Développeur Full Stack","job_slug":"developpeur-fullstack","motivation":"Candidature test pour vérifier les flux Directus.","cv":null}	{"status":"accepted"}	\N	\N
207	286	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	{"name":"_Test Email (temp)","icon":"mail","color":"#666","status":"active","trigger":"webhook","options":{"method":"POST"}}	{"name":"_Test Email (temp)","icon":"mail","color":"#666","status":"active","trigger":"webhook","options":{"method":"POST"}}	\N	\N
209	288	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	{"id":"d03b2e47-da0f-44fc-9302-715897f0687d","name":"_Test Email (temp)","icon":"mail","color":"#666","description":null,"status":"active","trigger":"webhook","accountability":"all","options":{"method":"POST"},"operation":"873ad65d-3428-4b38-b0cd-3800a9d0ad6d","date_created":"2026-02-06T09:23:26.347Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["873ad65d-3428-4b38-b0cd-3800a9d0ad6d"]}	{"operation":"873ad65d-3428-4b38-b0cd-3800a9d0ad6d"}	\N	\N
210	289	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	{"steps":[{"operation":"873ad65d-3428-4b38-b0cd-3800a9d0ad6d","key":"test_mail","status":"resolve","options":{"to":["minhadjenontin@gmail.com"],"subject":"[DOMMSOFT] Test email transport","body":"<p>Si vous recevez cet email, le transport SMTP fonctionne correctement.</p>","type":"text/html"}}],"data":{"$trigger":{"path":"/trigger/d03b2e47-da0f-44fc-9302-715897f0687d","query":{},"body":{},"method":"POST","headers":{"host":"localhost:8055","user-agent":"curl/8.7.1","accept":"*/*","content-type":"application/json","content-length":"2"}},"$last":null,"$accountability":{"role":null,"user":null,"roles":[],"admin":false,"app":false,"ip":"192.168.65.1","userAgent":"curl/8.7.1"},"$env":{},"test_mail":null}}	\N	\N	\N
198	273	directus_flows	ebd58ddf-7b37-446e-ada8-5fb0866902da	{"name":"Refuser la candidature","icon":"cancel","color":"#ef4444","description":"Bouton pour refuser une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous refuser cette candidature ? Un email sera envoyé au candidat."}}	{"name":"Refuser la candidature","icon":"cancel","color":"#ef4444","description":"Bouton pour refuser une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous refuser cette candidature ? Un email sera envoyé au candidat."}}	\N	\N
199	274	directus_operations	b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a	{"name":"Envoyer email refus","key":"send_refused_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_candidature_refus.email}}"],"subject":"Suite à votre candidature chez DOMMSOFT","body":"<h2>Bonjour {{read_candidature_refus.first_name}},</h2><p>Nous vous remercions pour l'intérêt que vous portez à DOMMSOFT et pour le temps consacré à votre candidature pour le poste <strong>\\"{{read_candidature_refus.job_title}}\\"</strong>.</p><p>Après étude attentive de votre dossier, nous avons le regret de vous informer que votre candidature n'a pas été retenue pour ce poste.</p><p>Nous conservons votre profil et ne manquerons pas de vous recontacter si une opportunité correspondant à votre profil se présente.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":null,"reject":null}	{"name":"Envoyer email refus","key":"send_refused_email","type":"mail","position_x":37,"position_y":1,"options":{"to":["{{read_candidature_refus.email}}"],"subject":"Suite à votre candidature chez DOMMSOFT","body":"<h2>Bonjour {{read_candidature_refus.first_name}},</h2><p>Nous vous remercions pour l'intérêt que vous portez à DOMMSOFT et pour le temps consacré à votre candidature pour le poste <strong>\\"{{read_candidature_refus.job_title}}\\"</strong>.</p><p>Après étude attentive de votre dossier, nous avons le regret de vous informer que votre candidature n'a pas été retenue pour ce poste.</p><p>Nous conservons votre profil et ne manquerons pas de vous recontacter si une opportunité correspondant à votre profil se présente.</p><br><p>Cordialement,<br><strong>L'équipe DOMMSOFT</strong></p>","type":"text/html"},"flow":"ebd58ddf-7b37-446e-ada8-5fb0866902da","resolve":null,"reject":null}	\N	\N
202	277	directus_flows	ebd58ddf-7b37-446e-ada8-5fb0866902da	{"id":"ebd58ddf-7b37-446e-ada8-5fb0866902da","name":"Refuser la candidature","icon":"cancel","color":"#ef4444","description":"Bouton pour refuser une candidature et notifier le candidat par email","status":"active","trigger":"manual","accountability":"all","options":{"collections":["applications"],"requireConfirmation":true,"confirmationDescription":"Voulez-vous refuser cette candidature ? Un email sera envoyé au candidat."},"operation":"fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92","date_created":"2026-02-06T09:15:55.478Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["b3b957d3-1529-4c1b-aa52-a84fd489e964","b88f7bfd-eef1-45c4-9ede-b4a1898c0b3a","fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92"]}	{"operation":"fee6ab99-4dc5-4ac7-9742-7b6cbb03cf92"}	\N	\N
203	278	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	{"steps":[{"operation":"3020d7db-904d-4d59-b756-e8194e509185","key":"read_candidature","status":"reject","options":{"collection":"applications","key":"undefined"}}],"data":{"$trigger":{"path":"/trigger/012fcd04-b4e2-482b-afdd-ec39ea068e89","query":{},"body":{"collection":"applications","keys":["98d36d5b-a158-4416-9c9c-d5f1863f2426"]},"method":"POST","headers":{"host":"localhost:8055","connection":"keep-alive","content-length":"77","sec-ch-ua-platform":"\\"macOS\\"","user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36","accept":"application/json, text/plain, */*","sec-ch-ua":"\\"Not(A:Brand\\";v=\\"8\\", \\"Chromium\\";v=\\"144\\", \\"Google Chrome\\";v=\\"144\\"","content-type":"application/json","sec-ch-ua-mobile":"?0","origin":"http://localhost:8055","sec-fetch-site":"same-origin","sec-fetch-mode":"cors","sec-fetch-dest":"empty","referer":"http://localhost:8055/admin/content/applications/98d36d5b-a158-4416-9c9c-d5f1863f2426","accept-encoding":"gzip, deflate, br, zstd","accept-language":"en-US,en;q=0.9,fr-FR;q=0.8,fr;q=0.7","cookie":"--redacted--"}},"$last":{"name":"DirectusError","message":"You don't have permission to access this."},"$accountability":{"role":"988ce776-97f5-4b0a-a973-976491e7ebca","user":"c0731d51-a5b8-49a9-901f-d0de152a48e6","roles":["988ce776-97f5-4b0a-a973-976491e7ebca"],"admin":true,"app":true,"ip":"192.168.65.1","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"MmtG_y7Vu9nVr-hq7yoDEGvm7R5MYXyoFCV1Wiw-TWi2971wnGpZWYaOb7iYofhz"},"$env":{},"read_candidature":{"name":"DirectusError","message":"You don't have permission to access this."}}}	\N	\N	\N
204	280	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	{"status":"pending","first_name":"Jean","last_name":"Dupont","email":"minhadjenontin@gmail.com","phone":"+33612345678","country":"France","job_title":"Développeur Full Stack","job_slug":"developpeur-fullstack","motivation":"Candidature test pour vérifier les flux Directus."}	{"status":"pending","first_name":"Jean","last_name":"Dupont","email":"minhadjenontin@gmail.com","phone":"+33612345678","country":"France","job_title":"Développeur Full Stack","job_slug":"developpeur-fullstack","motivation":"Candidature test pour vérifier les flux Directus."}	\N	\N
208	287	directus_operations	873ad65d-3428-4b38-b0cd-3800a9d0ad6d	{"name":"Test mail","key":"test_mail","type":"mail","position_x":19,"position_y":1,"options":{"to":["minhadjenontin@gmail.com"],"subject":"[DOMMSOFT] Test email transport","body":"<p>Si vous recevez cet email, le transport SMTP fonctionne correctement.</p>","type":"text/html"},"flow":"d03b2e47-da0f-44fc-9302-715897f0687d","resolve":null,"reject":null}	{"name":"Test mail","key":"test_mail","type":"mail","position_x":19,"position_y":1,"options":{"to":["minhadjenontin@gmail.com"],"subject":"[DOMMSOFT] Test email transport","body":"<p>Si vous recevez cet email, le transport SMTP fonctionne correctement.</p>","type":"text/html"},"flow":"d03b2e47-da0f-44fc-9302-715897f0687d","resolve":null,"reject":null}	\N	\N
211	290	directus_flows	d03b2e47-da0f-44fc-9302-715897f0687d	{"id":"d03b2e47-da0f-44fc-9302-715897f0687d","name":"_Test Email (temp)","icon":"mail","color":"#666","description":null,"status":"active","trigger":"webhook","accountability":"all","options":{"method":"POST"},"operation":null,"date_created":"2026-02-06T09:23:26.347Z","user_created":"c0731d51-a5b8-49a9-901f-d0de152a48e6","operations":["873ad65d-3428-4b38-b0cd-3800a9d0ad6d"]}	{"operation":null}	\N	\N
212	293	directus_flows	012fcd04-b4e2-482b-afdd-ec39ea068e89	{"steps":[{"operation":"3020d7db-904d-4d59-b756-e8194e509185","key":"read_candidature","status":"reject","options":{"collection":"applications","key":"undefined"}}],"data":{"$trigger":{"path":"/trigger/012fcd04-b4e2-482b-afdd-ec39ea068e89","query":{},"body":{"collection":"applications","keys":["98d36d5b-a158-4416-9c9c-d5f1863f2426"]},"method":"POST","headers":{"host":"localhost:8055","connection":"keep-alive","content-length":"77","sec-ch-ua-platform":"\\"macOS\\"","user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36","accept":"application/json, text/plain, */*","sec-ch-ua":"\\"Not(A:Brand\\";v=\\"8\\", \\"Chromium\\";v=\\"144\\", \\"Google Chrome\\";v=\\"144\\"","content-type":"application/json","sec-ch-ua-mobile":"?0","origin":"http://localhost:8055","sec-fetch-site":"same-origin","sec-fetch-mode":"cors","sec-fetch-dest":"empty","referer":"http://localhost:8055/admin/content/applications/98d36d5b-a158-4416-9c9c-d5f1863f2426","accept-encoding":"gzip, deflate, br, zstd","accept-language":"en-US,en;q=0.9,fr-FR;q=0.8,fr;q=0.7","cookie":"--redacted--"}},"$last":{"name":"DirectusError","message":"You don't have permission to access this."},"$accountability":{"role":"988ce776-97f5-4b0a-a973-976491e7ebca","user":"c0731d51-a5b8-49a9-901f-d0de152a48e6","roles":["988ce776-97f5-4b0a-a973-976491e7ebca"],"admin":true,"app":true,"ip":"192.168.65.1","userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36","origin":"http://localhost:8055","session":"gVncyNzWse80wNCmkfIDduUKivtBkOnfrycEJbpK-pTeg_P8odb4osGwwGptDCPF"},"$env":{},"read_candidature":{"name":"DirectusError","message":"You don't have permission to access this."}}}	\N	\N	\N
213	297	applications	0508625e-ac25-42d4-8fe8-1bdeb4c4d36f	{"id":"0508625e-ac25-42d4-8fe8-1bdeb4c4d36f","status":"pending","date_created":"2026-02-06T09:22:14.279Z","first_name":"Jean","last_name":"Dupont","email":"minhadjenontin@gmail.com","phone":"+33612345678","country":"France","job_title":"Développeur Full Stack","job_slug":"developpeur-fullstack","motivation":"Candidature test pour vérifier les flux Directus.","cv":null}	{"status":"pending"}	\N	\N
214	304	directus_fields	92	{"sort":14,"interface":"boolean","display":"boolean","special":["cast-boolean"],"note":"Afficher sur la homepage","collection":"products","field":"featured"}	{"sort":14,"interface":"boolean","display":"boolean","special":["cast-boolean"],"note":"Afficher sur la homepage","collection":"products","field":"featured"}	\N	\N
215	306	directus_fields	93	{"sort":15,"interface":"input","display":"raw","note":"URL externe du produit (ex: https://gestiloc.io)","collection":"products","field":"url"}	{"sort":15,"interface":"input","display":"raw","note":"URL externe du produit (ex: https://gestiloc.io)","collection":"products","field":"url"}	\N	\N
216	308	products	e843568b-1d7e-429b-811b-fb0ff92bde37	{"status":"published","sort":1,"name":"Gestiloc","slug":"gestiloc","description":"Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.","icon":"Building2","color":"text-[#2c85c5]","featured":true,"url":"https://gestiloc.io","features":["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"]}	{"status":"published","sort":1,"name":"Gestiloc","slug":"gestiloc","description":"Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.","icon":"Building2","color":"text-[#2c85c5]","featured":true,"url":"https://gestiloc.io","features":["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"]}	\N	\N
217	310	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-22T16:07:53.880Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","featured":true,"url":null}	{"featured":true,"url":null,"date_updated":"2026-02-22T16:07:53.880Z"}	\N	\N
218	311	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"id":"c5ce8492-a63a-4f34-a099-8368179a57ec","status":"published","sort":3,"date_created":"2026-02-04T17:14:10.060Z","date_updated":"2026-02-22T16:07:53.947Z","name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","content":null,"icon":"Users","color":"text-violet-500","features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"],"image":"752de803-5294-4947-930b-5dc379152447","featured":true,"url":null}	{"featured":true,"url":null,"date_updated":"2026-02-22T16:07:53.947Z"}	\N	\N
219	313	directus_fields	94	{"sort":16,"interface":"select-dropdown","display":"labels","options":{"choices":[{"text":"Entreprise","value":"entreprise"},{"text":"Particulier","value":"particulier"}]},"note":"Categorie pour le filtrage sur la homepage","collection":"products","field":"category"}	{"sort":16,"interface":"select-dropdown","display":"labels","options":{"choices":[{"text":"Entreprise","value":"entreprise"},{"text":"Particulier","value":"particulier"}]},"note":"Categorie pour le filtrage sur la homepage","collection":"products","field":"category"}	\N	\N
220	315	products	e843568b-1d7e-429b-811b-fb0ff92bde37	{"id":"e843568b-1d7e-429b-811b-fb0ff92bde37","status":"published","sort":1,"date_created":"2026-02-22T16:04:45.024Z","date_updated":"2026-02-22T16:19:57.169Z","name":"Gestiloc","slug":"gestiloc","description":"Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.","content":null,"icon":"Building2","color":"text-[#2c85c5]","features":["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"],"image":null,"featured":true,"url":"https://gestiloc.io","category":"particulier"}	{"category":"particulier","date_updated":"2026-02-22T16:19:57.169Z"}	\N	\N
221	316	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-22T16:19:57.211Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","featured":true,"url":null,"category":"entreprise"}	{"category":"entreprise","date_updated":"2026-02-22T16:19:57.211Z"}	\N	\N
222	317	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"id":"c5ce8492-a63a-4f34-a099-8368179a57ec","status":"published","sort":3,"date_created":"2026-02-04T17:14:10.060Z","date_updated":"2026-02-22T16:19:57.245Z","name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","content":null,"icon":"Users","color":"text-violet-500","features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"],"image":"752de803-5294-4947-930b-5dc379152447","featured":true,"url":null,"category":"entreprise"}	{"category":"entreprise","date_updated":"2026-02-22T16:19:57.245Z"}	\N	\N
223	321	directus_fields	94	{"id":94,"collection":"products","field":"category","special":["cast-json"],"interface":"select-multiple-dropdown","options":{"choices":[{"text":"Entreprise","value":"entreprise"},{"text":"Particulier","value":"particulier"}]},"display":"labels","display_options":null,"readonly":false,"hidden":false,"sort":16,"width":"full","translations":null,"note":"Categorie pour le filtrage sur la homepage","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"category","special":["cast-json"],"interface":"select-multiple-dropdown","options":{"choices":[{"text":"Entreprise","value":"entreprise"},{"text":"Particulier","value":"particulier"}]}}	\N	\N
224	324	products	e843568b-1d7e-429b-811b-fb0ff92bde37	{"id":"e843568b-1d7e-429b-811b-fb0ff92bde37","status":"published","sort":1,"date_created":"2026-02-22T16:04:45.024Z","date_updated":"2026-02-22T16:28:45.423Z","name":"Gestiloc","slug":"gestiloc","description":"Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.","content":null,"icon":"Building2","color":"text-[#2c85c5]","features":["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"],"image":null,"featured":true,"url":"https://gestiloc.io","category":["particulier","entreprise"]}	{"category":["particulier","entreprise"],"date_updated":"2026-02-22T16:28:45.423Z"}	\N	\N
225	325	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-22T16:28:45.452Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","featured":true,"url":null,"category":["entreprise"]}	{"category":["entreprise"],"date_updated":"2026-02-22T16:28:45.452Z"}	\N	\N
226	326	products	c5ce8492-a63a-4f34-a099-8368179a57ec	{"id":"c5ce8492-a63a-4f34-a099-8368179a57ec","status":"published","sort":3,"date_created":"2026-02-04T17:14:10.060Z","date_updated":"2026-02-22T16:28:45.475Z","name":"DommHR","slug":"dommhr","description":"Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.","content":null,"icon":"Users","color":"text-violet-500","features":["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"],"image":"752de803-5294-4947-930b-5dc379152447","featured":true,"url":null,"category":["entreprise"]}	{"category":["entreprise"],"date_updated":"2026-02-22T16:28:45.475Z"}	\N	\N
227	327	products	2b2969f9-a2d2-453e-adb6-53e6236b18f7	{"id":"2b2969f9-a2d2-453e-adb6-53e6236b18f7","status":"published","sort":4,"date_created":"2026-02-04T17:38:15.988Z","date_updated":"2026-02-22T16:28:45.501Z","name":"DommShop","slug":"dommshop","description":"Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.","content":null,"icon":"ShoppingBag","color":"text-orange-500","features":["Thèmes modernes personnalisables","Paiement natif via DommPay","Gestion des stocks en temps réel","SEO optimisé dès la mise en ligne"],"image":null,"featured":false,"url":null,"category":["entreprise","particulier"]}	{"category":["entreprise","particulier"],"date_updated":"2026-02-22T16:28:45.501Z"}	\N	\N
228	328	products	0a48c376-b5a2-443b-ae31-7a3ad816654a	{"id":"0a48c376-b5a2-443b-ae31-7a3ad816654a","status":"published","sort":2,"date_created":"2026-02-04T17:14:10.055Z","date_updated":"2026-02-22T16:29:31.187Z","name":"DommCloud","slug":"dommcloud","description":"Infrastructure cloud performante pour héberger vos applications et services SaaS.","content":null,"icon":"Cloud","color":"text-blue-500","features":["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","featured":true,"url":null,"category":["entreprise","particulier"]}	{"category":["entreprise","particulier"],"date_updated":"2026-02-22T16:29:31.187Z"}	\N	\N
229	331	directus_fields	95	{"note":"Logo de la solution (upload image)","collection":"products","field":"logo"}	{"note":"Logo de la solution (upload image)","collection":"products","field":"logo"}	\N	\N
230	332	products	e843568b-1d7e-429b-811b-fb0ff92bde37	{"id":"e843568b-1d7e-429b-811b-fb0ff92bde37","status":"published","sort":1,"date_created":"2026-02-22T16:04:45.024Z","date_updated":"2026-02-22T16:35:11.824Z","name":"Gestiloc","slug":"gestiloc","description":"Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.","content":null,"icon":"Building2","color":"text-[#2c85c5]","features":["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"],"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","featured":true,"url":"https://gestiloc.io","category":["particulier","entreprise"]}	{"image":"2a43a3f1-63dd-41f1-8042-d63451eaad23","date_updated":"2026-02-22T16:35:11.824Z"}	\N	\N
231	337	directus_fields	91	{"id":91,"collection":"products","field":"image","special":["file"],"interface":"file-image","options":{"crop":false},"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":null,"note":"Logo de la solution (uploadez le logo ici)","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"image","special":["file"],"interface":"file-image","options":{"crop":false},"display":"image","note":"Logo de la solution (uploadez le logo ici)"}	\N	\N
232	343	directus_fields	91	{"id":91,"collection":"products","field":"image","special":["file"],"interface":"file-image","options":{"crop":false},"display":"image","display_options":null,"readonly":false,"hidden":false,"sort":10,"width":"full","translations":[{"language":"en-US","translation":"Logo"},{"language":"fr-FR","translation":"Logo"}],"note":"Logo de la solution","conditions":null,"required":false,"group":null,"validation":null,"validation_message":null,"searchable":true}	{"collection":"products","field":"image","translations":[{"language":"en-US","translation":"Logo"},{"language":"fr-FR","translation":"Logo"}],"note":"Logo de la solution"}	\N	\N
233	345	directus_fields	96	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"stats"}	{"sort":1,"special":["uuid"],"interface":"input","readonly":true,"hidden":true,"field":"id","collection":"stats"}	\N	\N
235	347	directus_fields	98	{"sort":3,"interface":"select-dropdown","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"}]},"display":"labels","width":"half","field":"status","collection":"stats"}	{"sort":3,"interface":"select-dropdown","options":{"choices":[{"text":"Published","value":"published"},{"text":"Draft","value":"draft"}]},"display":"labels","width":"half","field":"status","collection":"stats"}	\N	\N
236	348	directus_collections	stats	{"icon":"bar_chart","note":"Chiffres cles affiches sur la homepage","sort_field":"sort","singleton":false,"collection":"stats"}	{"icon":"bar_chart","note":"Chiffres cles affiches sur la homepage","sort_field":"sort","singleton":false,"collection":"stats"}	\N	\N
237	350	directus_fields	99	{"sort":4,"interface":"input","note":"Le chiffre (ex: 1, 15, 100)","width":"half","required":true,"collection":"stats","field":"value"}	{"sort":4,"interface":"input","note":"Le chiffre (ex: 1, 15, 100)","width":"half","required":true,"collection":"stats","field":"value"}	\N	\N
238	351	directus_fields	100	{"sort":5,"interface":"input","note":"Texte apres le chiffre (ex: +, %, K)","width":"half","collection":"stats","field":"suffix"}	{"sort":5,"interface":"input","note":"Texte apres le chiffre (ex: +, %, K)","width":"half","collection":"stats","field":"suffix"}	\N	\N
239	352	directus_fields	101	{"sort":6,"interface":"input","note":"Description sous le chiffre (ex: Utilisateurs)","required":true,"collection":"stats","field":"label"}	{"sort":6,"interface":"input","note":"Description sous le chiffre (ex: Utilisateurs)","required":true,"collection":"stats","field":"label"}	\N	\N
240	354	stats	25358e7b-7a6b-4610-ab85-029967b554f7	{"value":1,"suffix":"","label":"Solution live","sort":1,"status":"published"}	{"value":1,"suffix":"","label":"Solution live","sort":1,"status":"published"}	\N	\N
241	355	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	{"value":2,"suffix":"","label":"Solutions en cours","sort":2,"status":"published"}	{"value":2,"suffix":"","label":"Solutions en cours","sort":2,"status":"published"}	\N	\N
242	356	stats	61f67f10-f533-4d01-bb29-562c2af3cc95	{"value":2,"suffix":"","label":"Continents vises","sort":3,"status":"published"}	{"value":2,"suffix":"","label":"Continents vises","sort":3,"status":"published"}	\N	\N
243	357	stats	75ef6b7a-19d2-417c-94e0-a3672d19e6fe	{"value":100,"suffix":"%","label":"Code sur mesure","sort":4,"status":"published"}	{"value":100,"suffix":"%","label":"Code sur mesure","sort":4,"status":"published"}	\N	\N
244	360	stats	25358e7b-7a6b-4610-ab85-029967b554f7	{"id":"25358e7b-7a6b-4610-ab85-029967b554f7","sort":1,"status":"published","value":1,"suffix":"","label":"Produit actif"}	{"value":1,"suffix":"","label":"Produit actif"}	\N	\N
245	361	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	{"id":"f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d","sort":2,"status":"published","value":2,"suffix":"","label":"Produits en cours de developpement"}	{"value":2,"suffix":"","label":"Produits en cours de developpement"}	\N	\N
246	362	stats	61f67f10-f533-4d01-bb29-562c2af3cc95	{"id":"61f67f10-f533-4d01-bb29-562c2af3cc95","sort":3,"status":"published","value":10000,"suffix":"+","label":"Utilisateurs"}	{"value":10000,"suffix":"+","label":"Utilisateurs"}	\N	\N
247	366	stats	f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	{"id":"f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d","sort":2,"status":"published","value":2,"suffix":"","label":"Produits en cours de développement"}	{"label":"Produits en cours de développement"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
988ce776-97f5-4b0a-a973-976491e7ebca	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
03xUGs3ivbHF3vqNFCSLZnzeVybywJ-edDYhuI7qYJdvVEJPltR0hJKPBCd-QOYI	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:17:07.763+00	172.19.0.1	curl/8.7.1	\N	\N	\N
2923dU_-pikQZC9gA4k3_rzwWE-FdJrK44Pnk-4rSIjgMc-MPCsag2Q_yGwxEaqT	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:19:56.782+00	172.19.0.1	curl/8.7.1	\N	\N	\N
JF_rcnTViiHRsvsjG_8jR-q5xmMb6jhMujx2tH-d-5WdApisqMMYvoVWerCShrSH	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:30:41.039+00	172.19.0.1	curl/8.7.1	\N	\N	\N
t3O29MT1jiu1Qckb916KIvPWluK3xrC2fVjaeq1Eprl5d-uMhp32M1c7nbn481vl	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:31:50.093+00	172.19.0.1	curl/8.7.1	\N	\N	\N
E7wLSa2oiBM8boFGVHhnaBzQxzJTwCjqtcnMfIsRxmoqJDWF5iQWrNMc1vqtPm1S	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:42:32.065+00	172.19.0.1	curl/8.7.1	\N	\N	\N
Vo3kQPUvGPtw7nirqjtOXt79tjf6TUhZ6Zh2Z5FWuu-NlVAIQ7Ii0hwPRL9k2kdD	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:42:43.281+00	172.19.0.1	curl/8.7.1	\N	\N	\N
paeZqBfWKIz754Y7V2VSl12GlOAacuNbbFKsgjNEOEvGbfIqvDwjP6V6AeK70n4-	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:01:26.914+00	172.19.0.1	curl/8.7.1	\N	\N	\N
OJziYPE6b8ICPdf05GkDAPJHbqE0qla90KVJ-4mrCDNb83xxN96_Vly4E5WKMro4	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:02:10.901+00	172.19.0.1	curl/8.7.1	\N	\N	\N
kWVtiQclVqFo2ZKiIbQYOhY-nAClfJELTe9wK490wBgEQfNT86U8KBxnB_Dubl4P	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-02-23 17:04:33.305+00	172.19.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
WbavXX3Mt3C8IpB724rYUOsFYJSV0j_PpMCfWm-ftBASS6AE-phJpgJFIO6KnMOG	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:01:57.272+00	172.19.0.1	curl/8.7.1	\N	\N	\N
BRbX-ZgHXtwHi8vOJPdy8urA-VUIdV5uKbHDaR7Lfgf_pcL92JN54kVw0gzCmrwY	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:02:12.757+00	172.19.0.1	curl/8.7.1	\N	\N	\N
iqU-jUs_R4qjvatrn5UHOllyQ3eO-eLka7gFCaW_Sw-LfKNwgVe9xz6UEF2V5xX9	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:02:29.324+00	172.19.0.1	curl/8.7.1	\N	\N	\N
kBkEgG-xw_rton6G8_FU0lH0Ynno8Ho6ud0ZygPe8RIoTWvpFtgM2tKuQxxbCizn	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:02:37.712+00	172.19.0.1	curl/8.7.1	\N	\N	\N
duG0TOkjBlOL0KMPIxFAm6rg-E2XdxD9SWPw0pP5C1bVUoxFolZDAGT30RvvvSyQ	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:03:51.596+00	172.19.0.1	curl/8.7.1	\N	\N	\N
WiOPQlsJd9-I8UVj_L5_18jTU6gj_NOt3Hi-87-Ls8rFfU2fRWEwKLdEjBZ3SbT0	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:04:03.717+00	172.19.0.1	curl/8.7.1	\N	\N	\N
AikFyeaCHxjgxydt2_-W7Bsg69kZqSU8zpDHUlYSBC1jragWYO_Eomgq9swA30_b	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:04:44.593+00	172.19.0.1	curl/8.7.1	\N	\N	\N
fHQNqOAsfqt6cTA1VPkct7WJmBOc6d19LT-vB-jI-s2VEttrq-22DnVq2ALXvddq	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:07:53.464+00	172.19.0.1	curl/8.7.1	\N	\N	\N
8Hr0J-gOy9ZOwYumpjHOkvN4VxDN5AcSrFbINzusxGzvEJAG376CP70oB4rxIENC	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:27:51.758+00	172.19.0.1	curl/8.7.1	\N	\N	\N
SyrRMRcqdV2Izi84L3GjzzIsjEcROiBhk2nA2sS8Vj7mYThOdDJLotJC3IccRZxE	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:27:59.696+00	172.19.0.1	curl/8.7.1	\N	\N	\N
v8gkoVNyVLZ5_O0jdhv23s8ViYhqzj4sxVThYsiaeuYQON4p8tDmZZeO-UD0fww3	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:28:14.427+00	172.19.0.1	curl/8.7.1	\N	\N	\N
1cjAMTSQgBkUBYmkRzhnTjOtNE2RALycCZkAoyL8BrkfQUIhcBqIkIhF_7eCNNz_	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:28:32.384+00	172.19.0.1	curl/8.7.1	\N	\N	\N
9UeRr14Iykq6OFxL3HqIMe2iq2efw9BJ_imACrWBA-6mUbSV6mvy4aE6aUSxE5_R	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:28:44.972+00	172.19.0.1	curl/8.7.1	\N	\N	\N
Uyc4RNT3ldLIA0Vhhd-_aKzn_qbjZ230y49jfDgs4C0ttRoCXZeUHtsiVLXRL3Us	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:37:37.167+00	172.19.0.1	curl/8.7.1	\N	\N	\N
DV6t_8xTTBFs5uFT5iIgYMYOMqTY-iMWLtf1_BUs8UqOmys74HXrok6RgAIJJqYg	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:37:49.247+00	172.19.0.1	curl/8.7.1	\N	\N	\N
FmOzwvT6QRCqxAYymxGIO-JJfLHeqFLaH_67ckCwtqVaHph5SFecXhefRaMdHuUb	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:38:38.435+00	172.19.0.1	curl/8.7.1	\N	\N	\N
nLbrwSbWq1eyRfDt-CEY5sosWNC4nlvTnSsiWOYSntyNRDuY2e5TrZzkkClofefU	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:38:50.321+00	172.19.0.1	curl/8.7.1	\N	\N	\N
dyGQXudR6KKqOqQ4Kk8_w0VaU7n-84DUlJeHVq3wbA84p_F2MkW4uZyJ5df0Zra8	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:39:08.661+00	172.19.0.1	curl/8.7.1	\N	\N	\N
Hpa4LqG9GdxiXZ9Kl9DwzPIrtvP5sEYRtsRH1tez9ONUHiiHzsrDMMEQJaLDXWvx	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 16:40:22.964+00	172.19.0.1	curl/8.7.1	\N	\N	\N
MH67i9v-pf1nRP3jWNSJ8QtuedC6jBN0Ql8OPPZ44Na0BAvahTTEsTbL7K5qnRhs	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:02:34.657+00	172.19.0.1	curl/8.7.1	\N	\N	\N
ysyg5sf7tm2wHZ34y1lbK8_HG6FgZKTdAMzay-ijZFSgDv06-ifY2ZjguHsY3NH_	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:04:50.315+00	172.19.0.1	curl/8.7.1	\N	\N	\N
cseleJzqFlFVIQ0DK5vUX6UB7XnOQAZmIZTAlZbt8I0soo_Wej9bLBVY0wiZRsW-	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:05:02.452+00	172.19.0.1	curl/8.7.1	\N	\N	\N
qqXVPiCV0ZiBuwq6z5W_rFA96MpYlu4aqdG6cb2bBXnAcWjVkcPhmAzUvbcYvy9R	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:18:35.159+00	172.19.0.1	curl/8.7.1	\N	\N	\N
y6xWkbyQ95fbr9ZCev294SosVRNwPwNF02hgbczYM6PdMx9CgBjQiRcFWFCM8b1t	c0731d51-a5b8-49a9-901f-d0de152a48e6	2026-03-01 17:18:42.898+00	172.19.0.1	curl/8.7.1	\N	\N	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt, project_owner, project_usage, org_name, product_updates, project_status, ai_openai_api_key, ai_anthropic_api_key, ai_system_prompt, ai_google_api_key, ai_openai_compatible_api_key, ai_openai_compatible_base_url, ai_openai_compatible_name, ai_openai_compatible_models, ai_openai_compatible_headers, ai_openai_allowed_models, ai_anthropic_allowed_models, ai_google_allowed_models, collaborative_editing_enabled) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N		\N	\N	\N	\N	\N	fr-FR	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	019c2996-e6fa-75fb-8060-fe2e4979e3d6	f	f	\N	t	\N	minhadjenontin@gmail.com	commercial	DOMMSOFT	f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	["gpt-5-nano","gpt-5-mini","gpt-5"]	["claude-haiku-4-5","claude-sonnet-4-5"]	["gemini-3-pro-preview","gemini-3-flash-preview","gemini-2.5-pro","gemini-2.5-flash"]	f
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications, appearance, theme_dark, theme_light, theme_light_overrides, theme_dark_overrides, text_direction) FROM stdin;
c0731d51-a5b8-49a9-901f-d0de152a48e6	Admin	User	minhadjenontin@gmail.com	$argon2id$v=19$m=65536,t=3,p=4$EmlxssAFruhHxetS1elEjQ$Z2gJws3+/R1mQaogLETLu/wkNSj+T7e5JB/7H56aQ8k	\N	\N	\N	\N	\N	\N	\N	active	988ce776-97f5-4b0a-a973-976491e7ebca	\N	2026-02-22 17:18:42.916+00	/content/stats	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: job_offers; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.job_offers (id, status, sort, date_created, date_updated, title, slug, department, location, type, description, content, date_published) FROM stdin;
60f53ced-681e-440b-aa6d-dd683fa3a202	published	1	2026-02-04 19:14:32.093+00	\N	Développeur Full-Stack Senior	developpeur-fullstack-senior	Ingénierie	Cotonou, Bénin	CDI	Rejoignez notre équipe technique pour concevoir et développer des solutions innovantes. Vous travaillerez sur l'ensemble de notre stack technique, du backend aux interfaces utilisateur.	<h2>À propos du poste</h2><p>En tant que Développeur Full-Stack Senior, vous jouerez un rôle clé dans la conception et le développement de nos produits phares : DommPay, DommCloud, DommHR et DommShop.</p><h2>Responsabilités</h2><ul><li>Concevoir et développer des fonctionnalités front-end et back-end</li><li>Participer aux revues de code et au mentorat des développeurs juniors</li><li>Collaborer avec l'équipe produit pour définir les spécifications techniques</li><li>Assurer la qualité du code et la couverture de tests</li><li>Contribuer à l'architecture technique des projets</li></ul><h2>Profil recherché</h2><ul><li>5+ ans d'expérience en développement web</li><li>Maîtrise de React/Next.js et Node.js</li><li>Expérience avec PostgreSQL et les API REST</li><li>Connaissance de TypeScript</li><li>Capacité à travailler en équipe dans un environnement agile</li></ul><h2>Ce que nous offrons</h2><ul><li>Salaire compétitif et avantages sociaux</li><li>Télétravail flexible</li><li>Budget formation annuel</li><li>Équipement de travail fourni</li><li>Environnement de travail stimulant et bienveillant</li></ul>	2026-01-30 09:00:00+00
c498ecb2-2677-475f-8538-9acea310f4b1	published	3	2026-02-04 19:14:32.182+00	\N	Chef de Projet Digital	chef-de-projet-digital	Opérations	Cotonou, Bénin	CDI	Pilotez nos projets digitaux de A à Z. Vous coordonnerez les équipes techniques et créatives pour livrer des solutions de qualité dans les délais.	<h2>À propos du poste</h2><p>Le Chef de Projet Digital sera le garant de la bonne exécution de nos projets, de la phase de cadrage jusqu'à la livraison. Vous serez l'interface entre nos clients internes, l'équipe technique et la direction.</p><h2>Responsabilités</h2><ul><li>Planifier et piloter les projets digitaux</li><li>Coordonner les équipes de développement et design</li><li>Gérer les budgets et les délais</li><li>Assurer la communication avec les parties prenantes</li><li>Identifier et gérer les risques projet</li></ul><h2>Profil recherché</h2><ul><li>3+ ans d'expérience en gestion de projets digitaux</li><li>Connaissance des méthodologies agiles (Scrum, Kanban)</li><li>Excellentes capacités de communication</li><li>Sens de l'organisation et rigueur</li><li>Compréhension des enjeux techniques</li></ul><h2>Ce que nous offrons</h2><ul><li>Rôle clé dans une entreprise en croissance</li><li>Projets variés et stimulants</li><li>Formation continue en management</li><li>Environnement multiculturel</li><li>Perspectives d'évolution rapide</li></ul>	2026-01-18 08:00:00+00
c550eba6-00ef-403e-b3b8-c0223dce56d8	published	2	2026-02-04 19:14:32.162+00	2026-02-04 20:01:21.977+00	Designer UI/UX	designer-ui-ux	Design	Remote	CDI	Nous cherchons un designer talentueux pour créer des interfaces intuitives et esthétiques. Vous serez au cœur de l'expérience utilisateur de nos produits.	<h3>&Agrave; propos du poste</h3>\n<p>En tant que Designer UI/UX, vous serez responsable de l'exp&eacute;rience utilisateur de l'ensemble de nos produits digitaux. Vous travaillerez en &eacute;troite collaboration avec les d&eacute;veloppeurs et l'&eacute;quipe produit.</p>\n<h2>Responsabilit&eacute;s</h2>\n<ul>\n<li>Concevoir des maquettes et prototypes interactifs</li>\n<li>Mener des recherches utilisateurs et des tests d'usabilit&eacute;</li>\n<li>Cr&eacute;er et maintenir notre design system</li>\n<li>Collaborer avec les d&eacute;veloppeurs pour assurer la fid&eacute;lit&eacute; des impl&eacute;mentations</li>\n<li>Contribuer &agrave; la strat&eacute;gie produit</li>\n</ul>\n<h2>Profil recherch&eacute;</h2>\n<ul>\n<li>3+ ans d'exp&eacute;rience en design UI/UX</li>\n<li>Ma&icirc;trise de Figma</li>\n<li>Portfolio d&eacute;montrant une approche centr&eacute;e utilisateur</li>\n<li>Sensibilit&eacute; pour l'accessibilit&eacute; et le design inclusif</li>\n<li>Bonne communication en fran&ccedil;ais et en anglais</li>\n</ul>\n<h2>Ce que nous offrons</h2>\n<ul>\n<li>Travail 100% remote</li>\n<li>Horaires flexibles</li>\n<li>Licence Figma et outils de design</li>\n<li>Participation &agrave; des conf&eacute;rences design</li>\n<li>&Eacute;quipe cr&eacute;ative et collaborative</li>\n</ul>	2026-01-25 10:00:00+00
\.


--
-- Data for Name: newsletter_subscribers; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.newsletter_subscribers (id, email, date_created) FROM stdin;
9a46a93e-f0e1-45e3-96fd-324b7d9cbd59	dedsqdqsd@gmail.com	2026-02-04 17:50:11.393+00
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.products (id, status, sort, date_created, date_updated, name, slug, description, content, icon, color, features, image, featured, url, category) FROM stdin;
e843568b-1d7e-429b-811b-fb0ff92bde37	published	1	2026-02-22 16:04:45.024+00	2026-02-22 16:35:11.824+00	Gestiloc	gestiloc	Gestion locative en ligne. Biens, locataires, contrats, loyers et quittances dans un seul outil.	\N	Building2	text-[#2c85c5]	["Gestion des biens et locataires","Contrats et baux automatises","Suivi des loyers en temps reel","Quittances PDF en un clic"]	2a43a3f1-63dd-41f1-8042-d63451eaad23	t	https://gestiloc.io	["particulier","entreprise"]
c5ce8492-a63a-4f34-a099-8368179a57ec	published	3	2026-02-04 17:14:10.06+00	2026-02-22 16:28:45.475+00	DommHR	dommhr	Gestion des ressources humaines simplifiée. Paie, congés, recrutement en un seul outil.	\N	Users	text-violet-500	["Gestion de la paie multi-pays","Suivi des congés, absences et présences","Portail collaborateur en libre-service","Rapports RH générés automatiquement"]	752de803-5294-4947-930b-5dc379152447	t	\N	["entreprise"]
2b2969f9-a2d2-453e-adb6-53e6236b18f7	published	4	2026-02-04 17:38:15.988+00	2026-02-22 16:28:45.501+00	DommShop	dommshop	Plateforme e-commerce complète pour lancer votre boutique en ligne en quelques minutes.	\N	ShoppingBag	text-orange-500	["Thèmes modernes personnalisables","Paiement natif via DommPay","Gestion des stocks en temps réel","SEO optimisé dès la mise en ligne"]	\N	f	\N	["entreprise","particulier"]
0a48c376-b5a2-443b-ae31-7a3ad816654a	published	2	2026-02-04 17:14:10.055+00	2026-02-22 16:29:31.187+00	DommCloud	dommcloud	Infrastructure cloud performante pour héberger vos applications et services SaaS.	\N	Cloud	text-blue-500	["Déploiement en un clic depuis Git","Auto-scaling intelligent selon la charge","Datacenters multi-régions","Uptime garanti à 99,9 %"]	2a43a3f1-63dd-41f1-8042-d63451eaad23	t	\N	["entreprise","particulier"]
\.


--
-- Data for Name: site_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.site_settings (id, hero_title, hero_subtitle, hero_description, hero_badge, cta_primary_text, cta_primary_url, cta_secondary_text, cta_secondary_url, social_twitter, social_linkedin, social_github, footer_newsletter_title, footer_newsletter_description, legal_mentions, privacy_policy, terms_of_use) FROM stdin;
af52b75b-38ba-4a28-8b5a-0809b1456f54	Nous imaginons le numérique de demain.dsds	Pensé pour tous.	DOMMSOFT combine savoir-faire technique et créativité pour concevoir des produits numériques qui répondent à de vrais besoins.	L'innovation au service de tous	Découvrir nos solutions	#products	Donnez vie à votre idée	/contact	https://twitter.com/dommsoft	https://linkedin.com/company/dommsoft	https://github.com/dommsoft	Restez informé de nos nouveautés	Recevez nos actualités produits, guides techniques et invitations événementielles directement dans votre boîte mail.	<h2>Éditeur du site</h2><p>DOMMSOFT<br>Société par actions simplifiée<br>Siège social : Cotonou, Bénin</p><h2>Directeur de la publication</h2><p>Le représentant légal de la société DOMMSOFT.</p><h2>Hébergement</h2><p>Ce site est hébergé par Vercel Inc.<br>440 N Barranca Ave #4133<br>Covina, CA 91723, États-Unis</p><h2>Propriété intellectuelle</h2><p>L'ensemble du contenu de ce site (textes, images, vidéos, logos, marques) est protégé par le droit de la propriété intellectuelle. Toute reproduction, représentation ou diffusion, totale ou partielle, du contenu de ce site sans autorisation préalable est interdite.</p><h2>Contact</h2><p>Pour toute question relative aux mentions légales, vous pouvez nous contacter à l'adresse : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>	<h2>Introduction</h2><p>DOMMSOFT s'engage à protéger la vie privée de ses utilisateurs. Cette politique de confidentialité décrit comment nous collectons, utilisons et protégeons vos données personnelles.</p><h2>Données collectées</h2><p>Nous collectons les données suivantes :</p><ul><li>Données d'identification : nom, prénom, adresse email</li><li>Données de contact : numéro de téléphone, pays</li><li>Données de candidature : CV, lettre de motivation</li><li>Données de navigation : cookies, adresse IP</li></ul><h2>Finalités du traitement</h2><p>Vos données sont utilisées pour :</p><ul><li>Répondre à vos demandes de contact</li><li>Traiter vos candidatures</li><li>Vous envoyer notre newsletter (avec votre consentement)</li><li>Améliorer nos services</li></ul><h2>Durée de conservation</h2><p>Vos données sont conservées pendant une durée maximale de 3 ans à compter de votre dernier contact avec nous.</p><h2>Vos droits</h2><p>Conformément à la réglementation en vigueur, vous disposez des droits suivants : accès, rectification, suppression, opposition, limitation et portabilité de vos données. Pour exercer ces droits, contactez-nous à : <a href='mailto:privacy@dommsoft.com'>privacy@dommsoft.com</a></p>	<h2>Objet</h2><p>Les présentes conditions générales d'utilisation (CGU) régissent l'accès et l'utilisation du site web dommsoft.com.</p><h2>Accès au site</h2><p>L'accès au site est gratuit. Les frais d'accès et d'utilisation du réseau de télécommunication sont à la charge de l'utilisateur.</p><h2>Utilisation du site</h2><p>L'utilisateur s'engage à utiliser le site de manière conforme à sa destination et à ne pas porter atteinte à l'ordre public ni aux droits de tiers.</p><h2>Propriété intellectuelle</h2><p>Tous les éléments du site (textes, images, logos, code source) sont la propriété exclusive de DOMMSOFT ou de ses partenaires. Toute reproduction non autorisée constitue une contrefaçon.</p><h2>Responsabilité</h2><p>DOMMSOFT s'efforce de fournir des informations exactes et à jour. Toutefois, nous ne pouvons garantir l'exactitude, la complétude ou l'actualité des informations diffusées sur le site.</p><h2>Modification des CGU</h2><p>DOMMSOFT se réserve le droit de modifier les présentes CGU à tout moment. Les modifications prennent effet dès leur publication sur le site.</p><h2>Contact</h2><p>Pour toute question relative aux présentes CGU, contactez-nous à : <a href='mailto:contact@dommsoft.com'>contact@dommsoft.com</a></p>
\.


--
-- Data for Name: stats; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.stats (id, sort, status, value, suffix, label) FROM stdin;
25358e7b-7a6b-4610-ab85-029967b554f7	1	published	1		Produit actif
61f67f10-f533-4d01-bb29-562c2af3cc95	3	published	10000	+	Utilisateurs
f7b1e9ff-d4f7-4c5e-a7f6-936af79f253d	2	published	2		Produits en cours de développement
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.testimonials (id, status, sort, quote, name, role, company, avatar) FROM stdin;
\.


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 366, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 101, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 8, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 8, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 4, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 247, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- Name: blog_posts blog_posts_slug_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_unique UNIQUE (slug);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: directus_access directus_access_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_comments directus_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_pkey PRIMARY KEY (id);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_deployment_projects directus_deployment_projects_deployment_external_id_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_deployment_external_id_unique UNIQUE (deployment, external_id);


--
-- Name: directus_deployment_projects directus_deployment_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_pkey PRIMARY KEY (id);


--
-- Name: directus_deployment_runs directus_deployment_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_pkey PRIMARY KEY (id);


--
-- Name: directus_deployments directus_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_pkey PRIMARY KEY (id);


--
-- Name: directus_deployments directus_deployments_provider_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_provider_unique UNIQUE (provider);


--
-- Name: directus_extensions directus_extensions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_extensions
    ADD CONSTRAINT directus_extensions_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_policies directus_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_policies
    ADD CONSTRAINT directus_policies_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_versions directus_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_pkey PRIMARY KEY (id);


--
-- Name: job_offers job_offers_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.job_offers
    ADD CONSTRAINT job_offers_pkey PRIMARY KEY (id);


--
-- Name: job_offers job_offers_slug_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.job_offers
    ADD CONSTRAINT job_offers_slug_unique UNIQUE (slug);


--
-- Name: newsletter_subscribers newsletter_subscribers_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_email_unique UNIQUE (email);


--
-- Name: newsletter_subscribers newsletter_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products products_slug_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_slug_unique UNIQUE (slug);


--
-- Name: site_settings site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.site_settings
    ADD CONSTRAINT site_settings_pkey PRIMARY KEY (id);


--
-- Name: stats stats_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: directus_activity_timestamp_index; Type: INDEX; Schema: public; Owner: directus
--

CREATE INDEX directus_activity_timestamp_index ON public.directus_activity USING btree ("timestamp");


--
-- Name: directus_revisions_activity_index; Type: INDEX; Schema: public; Owner: directus
--

CREATE INDEX directus_revisions_activity_index ON public.directus_revisions USING btree (activity);


--
-- Name: directus_revisions_parent_index; Type: INDEX; Schema: public; Owner: directus
--

CREATE INDEX directus_revisions_parent_index ON public.directus_revisions USING btree (parent);


--
-- Name: applications applications_cv_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_cv_foreign FOREIGN KEY (cv) REFERENCES public.directus_files(id);


--
-- Name: blog_posts blog_posts_cover_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_cover_image_foreign FOREIGN KEY (cover_image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: directus_access directus_access_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_access directus_access_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_access
    ADD CONSTRAINT directus_access_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_comments directus_comments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_comments directus_comments_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_comments
    ADD CONSTRAINT directus_comments_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployment_projects directus_deployment_projects_deployment_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_deployment_foreign FOREIGN KEY (deployment) REFERENCES public.directus_deployments(id) ON DELETE CASCADE;


--
-- Name: directus_deployment_projects directus_deployment_projects_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_projects
    ADD CONSTRAINT directus_deployment_projects_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployment_runs directus_deployment_runs_project_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_project_foreign FOREIGN KEY (project) REFERENCES public.directus_deployment_projects(id) ON DELETE CASCADE;


--
-- Name: directus_deployment_runs directus_deployment_runs_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployment_runs
    ADD CONSTRAINT directus_deployment_runs_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_deployments directus_deployments_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_deployments
    ADD CONSTRAINT directus_deployments_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_policy_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_policy_foreign FOREIGN KEY (policy) REFERENCES public.directus_policies(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_revisions directus_revisions_version_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_version_foreign FOREIGN KEY (version) REFERENCES public.directus_versions(id) ON DELETE CASCADE;


--
-- Name: directus_roles directus_roles_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_roles(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_favicon_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_favicon_foreign FOREIGN KEY (public_favicon) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_registration_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_registration_role_foreign FOREIGN KEY (public_registration_role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_versions directus_versions_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_versions directus_versions_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_versions
    ADD CONSTRAINT directus_versions_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: products products_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict 0af8CBngfQ038pwHH3umWnra8Z3sSFTaHky1IxeP11bYLki2Z2tFIETdkWFu9wm

