--
-- PostgreSQL database dump
--

\restrict 7xyLzaefmaZPJbmn0ty8BsyGCDN0LeTgYAdeU7yDkvIYBJTUdvULM1hRBiQ9ubi

-- Dumped from database version 15.15 (Debian 15.15-1.pgdg13+1)
-- Dumped by pg_dump version 15.15 (Debian 15.15-1.pgdg13+1)

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
-- Name: categories; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    name character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying,
    date_created timestamp with time zone,
    date_updated timestamp with time zone
);


ALTER TABLE public.categories OWNER TO directus;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO directus;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


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
    ai_system_prompt text
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
-- Name: inventory; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.inventory (
    id integer NOT NULL,
    product_name character varying(255),
    sku character varying(255),
    quantity integer DEFAULT 0,
    price numeric(10,5),
    category character varying(255),
    description text,
    reorder_level integer DEFAULT 10,
    supplier character varying(255),
    status character varying(255) DEFAULT 'in_stock'::character varying,
    user_created uuid,
    user_updated uuid,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    unit character varying(255)
);


ALTER TABLE public.inventory OWNER TO directus;

--
-- Name: inventory_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.inventory_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_id_seq OWNER TO directus;

--
-- Name: inventory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.inventory_id_seq OWNED BY public.inventory.id;


--
-- Name: inventory_images; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.inventory_images (
    id integer NOT NULL,
    inventory_id integer NOT NULL,
    directus_files_id uuid,
    date_created timestamp with time zone
);


ALTER TABLE public.inventory_images OWNER TO directus;

--
-- Name: inventory_images_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.inventory_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.inventory_images_id_seq OWNER TO directus;

--
-- Name: inventory_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.inventory_images_id_seq OWNED BY public.inventory_images.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    order_id integer,
    inventory_id integer,
    product_name character varying(255),
    quantity integer,
    unit_price numeric(15,2) DEFAULT NULL::numeric,
    subtotal numeric(15,2) DEFAULT NULL::numeric
);


ALTER TABLE public.order_items OWNER TO directus;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.order_items_id_seq OWNER TO directus;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_created uuid,
    date_created timestamp with time zone,
    user_updated uuid,
    date_updated timestamp with time zone,
    customer_name character varying(255),
    customer_email character varying(255),
    customer_phone character varying(255),
    shipping_address text,
    payment_method character varying(255),
    status character varying(255),
    subtotal numeric(15,2) DEFAULT NULL::numeric,
    shipping_fee numeric(15,2) DEFAULT NULL::numeric,
    total_amount numeric(15,2) DEFAULT NULL::numeric,
    notes text,
    user_id character varying(255)
);


ALTER TABLE public.orders OWNER TO directus;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO directus;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: units; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.units (
    id integer NOT NULL,
    name character varying(255),
    abbreviation character varying(255),
    status character varying(255) DEFAULT 'active'::character varying,
    date_created timestamp with time zone,
    date_updated timestamp with time zone
);


ALTER TABLE public.units OWNER TO directus;

--
-- Name: units_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.units_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.units_id_seq OWNER TO directus;

--
-- Name: units_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.units_id_seq OWNED BY public.units.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


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
-- Name: inventory id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.inventory ALTER COLUMN id SET DEFAULT nextval('public.inventory_id_seq'::regclass);


--
-- Name: inventory_images id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.inventory_images ALTER COLUMN id SET DEFAULT nextval('public.inventory_images_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: units id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.units ALTER COLUMN id SET DEFAULT nextval('public.units_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.categories (id, name, description, status, date_created, date_updated) FROM stdin;
1	Fabric	Various types of fabric materials	active	2026-01-17 20:09:32.421+00	\N
2	Thread	Sewing threads and yarns	active	2026-01-17 20:09:32.438+00	\N
3	Accessories	Buttons, zippers, and other accessories	active	2026-01-17 20:09:32.452+00	\N
\.


--
-- Data for Name: directus_access; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_access (id, role, "user", policy, sort) FROM stdin;
342f42cc-5c57-4c85-98de-b8594f201640	\N	\N	abf8a154-5b1c-4a46-ac9c-7300570f4f17	1
192c148e-8617-40c9-a1c9-bf62466c4ff0	677626c9-1d30-4155-9226-87162d9c9a10	\N	d9ad76d0-9756-4436-b4f1-bf6c1b2927c2	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, origin) FROM stdin;
1	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:20:18.169+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8055
2	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:26:55.731+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8055
3	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:27:16.125+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_settings	1	http://localhost:8055
4	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:33:17.503+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
5	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:34:41.202+00	192.168.65.1	curl/8.7.1	directus_fields	1	\N
6	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:34:41.203+00	192.168.65.1	curl/8.7.1	directus_collections	inventory	\N
7	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.455+00	192.168.65.1	curl/8.7.1	directus_fields	2	\N
8	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.498+00	192.168.65.1	curl/8.7.1	directus_fields	3	\N
9	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.527+00	192.168.65.1	curl/8.7.1	directus_fields	4	\N
10	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.559+00	192.168.65.1	curl/8.7.1	directus_fields	5	\N
11	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.586+00	192.168.65.1	curl/8.7.1	directus_fields	6	\N
12	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.614+00	192.168.65.1	curl/8.7.1	directus_fields	7	\N
13	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.645+00	192.168.65.1	curl/8.7.1	directus_fields	8	\N
14	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.678+00	192.168.65.1	curl/8.7.1	directus_fields	9	\N
15	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:35:29.728+00	192.168.65.1	curl/8.7.1	directus_fields	10	\N
16	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:36:25.585+00	192.168.65.1	curl/8.7.1	inventory	1	\N
17	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:39:06.97+00	192.168.65.1	curl/8.7.1	directus_fields	11	\N
18	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:39:07.016+00	192.168.65.1	curl/8.7.1	directus_fields	12	\N
19	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:39:07.064+00	192.168.65.1	curl/8.7.1	directus_fields	13	\N
20	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:39:07.108+00	192.168.65.1	curl/8.7.1	directus_fields	14	\N
21	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:39:25.827+00	192.168.65.1	curl/8.7.1	inventory	2	\N
22	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:40:26.782+00	192.168.65.1	curl/8.7.1	inventory	2	\N
23	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:43:34.206+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
24	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:43:34.669+00	192.168.65.1	curl/8.7.1	directus_fields	15	\N
25	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:48:20.918+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
26	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:50:54.279+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
27	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:56.878+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
28	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.348+00	192.168.65.1	curl/8.7.1	inventory	3	\N
29	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.366+00	192.168.65.1	curl/8.7.1	inventory	4	\N
30	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.379+00	192.168.65.1	curl/8.7.1	inventory	5	\N
31	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.392+00	192.168.65.1	curl/8.7.1	inventory	6	\N
32	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.404+00	192.168.65.1	curl/8.7.1	inventory	7	\N
33	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:55:03.406+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
34	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:57:37.868+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
35	delete	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:57:38.337+00	192.168.65.1	curl/8.7.1	inventory	1	\N
36	delete	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:57:38.352+00	192.168.65.1	curl/8.7.1	inventory	2	\N
37	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:59:06.459+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	inventory	8	http://localhost:8080
38	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:00:06.522+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
39	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:00:08.75+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
40	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:06:37.311+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
41	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:06:37.783+00	192.168.65.1	curl/8.7.1	directus_fields	16	\N
42	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:06:37.786+00	192.168.65.1	curl/8.7.1	directus_collections	categories	\N
43	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.198+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
44	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.661+00	192.168.65.1	curl/8.7.1	directus_fields	17	\N
45	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.7+00	192.168.65.1	curl/8.7.1	directus_fields	18	\N
46	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.727+00	192.168.65.1	curl/8.7.1	directus_fields	19	\N
47	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.754+00	192.168.65.1	curl/8.7.1	directus_fields	20	\N
48	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:10.778+00	192.168.65.1	curl/8.7.1	directus_fields	21	\N
49	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.179+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
50	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.652+00	192.168.65.1	curl/8.7.1	directus_fields	22	\N
51	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.655+00	192.168.65.1	curl/8.7.1	directus_collections	units	\N
52	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.677+00	192.168.65.1	curl/8.7.1	directus_fields	23	\N
53	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.709+00	192.168.65.1	curl/8.7.1	directus_fields	24	\N
54	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.733+00	192.168.65.1	curl/8.7.1	directus_fields	25	\N
55	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.758+00	192.168.65.1	curl/8.7.1	directus_fields	26	\N
56	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:08:35.782+00	192.168.65.1	curl/8.7.1	directus_fields	27	\N
57	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:31.96+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
58	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.423+00	192.168.65.1	curl/8.7.1	categories	1	\N
59	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.439+00	192.168.65.1	curl/8.7.1	categories	2	\N
60	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.453+00	192.168.65.1	curl/8.7.1	categories	3	\N
61	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.465+00	192.168.65.1	curl/8.7.1	units	1	\N
62	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.476+00	192.168.65.1	curl/8.7.1	units	2	\N
63	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.492+00	192.168.65.1	curl/8.7.1	units	3	\N
64	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.513+00	192.168.65.1	curl/8.7.1	units	4	\N
65	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:09:32.525+00	192.168.65.1	curl/8.7.1	units	5	\N
66	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:10:28.071+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
67	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:17:11.522+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
68	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:19:19.716+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
69	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 20:19:37.065+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
70	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:21:56.48+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
71	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:21:56.943+00	192.168.65.1	curl/8.7.1	directus_fields	28	\N
72	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:21:56.947+00	192.168.65.1	curl/8.7.1	directus_collections	inventory_images	\N
73	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:24:22.668+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
74	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:24:23.133+00	192.168.65.1	curl/8.7.1	directus_fields	29	\N
75	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:24:23.168+00	192.168.65.1	curl/8.7.1	directus_fields	30	\N
76	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:24:23.209+00	192.168.65.1	curl/8.7.1	directus_fields	31	\N
77	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:25:08.429+00	192.168.65.1	curl/8.7.1	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N
78	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:25:49.141+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
79	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:25:49.142+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
80	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:25:49.142+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
81	delete	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:33:06.541+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	inventory	8	http://localhost:8080
82	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:37:25.443+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	inventory	6	http://localhost:8080
83	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:39:05.909+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
84	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:39:05.91+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
85	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:39:05.911+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
87	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.163+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
86	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.163+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
88	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.167+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
89	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.49+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
90	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.49+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
91	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:41:00.491+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
93	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:45:57.353+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
92	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:45:57.352+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
94	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:45:57.353+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
97	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:48:09.202+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
99	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:50:51.67+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
95	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:48:09.196+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
96	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:48:09.197+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
98	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:50:51.667+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
100	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:50:51.671+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
101	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:56:12.431+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
102	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:56:12.433+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
103	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:56:12.434+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
104	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:15.926+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	6	http://localhost:8080
105	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:15.967+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	bf638d96-846b-47a5-b56b-5fba4d2edb43	http://localhost:8080
106	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:15.99+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory_images	1	http://localhost:8080
107	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.003+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	a5e977e2-01df-43d0-83c7-13f998bec552	http://localhost:8080
108	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.017+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory_images	2	http://localhost:8080
109	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.029+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	49cf37b3-efbd-4c09-85df-ac2b2b9dc16f	http://localhost:8080
110	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.041+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory_images	3	http://localhost:8080
111	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.052+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782	http://localhost:8080
112	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.065+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory_images	4	http://localhost:8080
113	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.075+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_files	c01a1aa0-993e-4a1c-8676-4ec30cb69811	http://localhost:8080
114	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.089+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory_images	5	http://localhost:8080
115	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:59:18.626+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
116	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:59:18.627+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
117	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:59:18.629+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
118	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:36:53.095+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
119	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:36:53.097+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
120	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:36:53.098+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
121	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:54:56.234+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8081
122	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:56:21.148+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
123	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:56:21.148+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
124	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 22:56:21.148+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
125	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:12:57.705+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
126	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:12:57.705+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
127	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:12:57.706+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
128	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:08.184+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
130	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:08.184+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
132	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:14.221+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
133	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:14.223+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
134	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:14:05.019+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
135	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:14:05.02+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
137	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:17:26.476+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	6	http://localhost:8080
129	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:08.184+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
131	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:13:14.22+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
136	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 00:14:05.02+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
138	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.821+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	32	http://localhost:8055
139	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.823+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	33	http://localhost:8055
140	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.825+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	34	http://localhost:8055
141	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.827+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	35	http://localhost:8055
142	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.829+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	36	http://localhost:8055
143	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:37.832+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_collections	orders	http://localhost:8055
144	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:01:53.57+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	37	http://localhost:8055
145	delete	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:02:01.379+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	37	http://localhost:8055
146	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:02:06.147+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	38	http://localhost:8055
147	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:02:16.691+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	39	http://localhost:8055
148	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:02:26.771+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	40	http://localhost:8055
149	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:11:30.658+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	41	http://localhost:8055
150	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:13:03.082+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	42	http://localhost:8055
151	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:15:30.469+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	43	http://localhost:8055
152	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:16:14.533+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	44	http://localhost:8055
153	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:16:26.604+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	45	http://localhost:8055
154	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:16:43.095+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	46	http://localhost:8055
155	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:17:06.218+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	47	http://localhost:8055
156	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:17:26.904+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	48	http://localhost:8055
157	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.773+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	49	http://localhost:8055
158	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.778+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	50	http://localhost:8055
159	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.78+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	51	http://localhost:8055
160	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.783+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	52	http://localhost:8055
161	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.785+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	53	http://localhost:8055
162	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:27.787+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_collections	order_items	http://localhost:8055
163	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:18:55.477+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	54	http://localhost:8055
164	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:19:25.027+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	55	http://localhost:8055
165	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:19:46.396+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	56	http://localhost:8055
166	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:20:00.044+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	57	http://localhost:8055
167	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:20:13.101+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	58	http://localhost:8055
168	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:20:24.486+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	59	http://localhost:8055
169	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:22:11.558+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_fields	60	http://localhost:8055
170	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:48:41.856+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	1	http://localhost:8081
171	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:48:41.873+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	1	http://localhost:8081
172	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:03:26.98+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
173	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:03:26.98+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
174	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:03:26.981+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
175	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:07:24.934+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
176	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:07:24.934+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
177	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:14:19.619+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
178	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:14:19.639+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
179	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:14:19.639+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
180	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:14:19.639+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
181	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:14:19.657+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
182	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:48.181+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	2	http://localhost:8081
183	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:48.208+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	2	http://localhost:8081
184	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:56.076+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
185	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:56.088+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
186	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:56.09+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
187	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:56.092+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
188	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:56.11+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
189	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:17:00.391+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	2	http://localhost:8080
190	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:17:30.553+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	2	http://localhost:8080
191	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:20:41.709+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	3	http://localhost:8081
192	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:20:41.726+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	3	http://localhost:8081
193	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:22:47.056+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
194	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:22:47.072+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
195	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:22:47.072+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
196	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:22:47.075+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
197	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:22:47.093+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
198	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:23:38.355+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
199	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:23:38.361+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
200	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:24:54.876+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	2	http://localhost:8080
201	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:04.325+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
202	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:04.332+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
203	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:04.333+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
204	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:04.333+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
205	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:04.352+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
206	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:12.107+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	3	http://localhost:8080
207	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:12.136+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	3	http://localhost:8080
208	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:25.94+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	5	http://localhost:8080
209	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:25.979+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	1	http://localhost:8080
210	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:07.619+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	4	http://localhost:8081
211	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:07.635+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	4	http://localhost:8081
213	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:36.481+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
214	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:36.481+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
212	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:36.48+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
215	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:36.486+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
216	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:36.501+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
217	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.23+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	5	http://localhost:8081
218	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.261+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	5	http://localhost:8081
219	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.268+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	6	http://localhost:8081
220	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.269+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	7	http://localhost:8081
221	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:05.839+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
222	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:05.851+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
223	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:05.851+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
224	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:05.854+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
225	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:05.869+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8080
226	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:15.519+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	5	http://localhost:8080
227	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:15.539+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	6	http://localhost:8080
228	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:15.561+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	7	http://localhost:8080
229	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:15.584+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	5	http://localhost:8080
230	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:11:37.738+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8055
231	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:21.184+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
232	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:56.443+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
233	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:56.473+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
234	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:56.488+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
235	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:56.489+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
236	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:12:56.499+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
237	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:13:53.504+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	6	http://localhost:8083
238	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:13:53.525+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	8	http://localhost:8083
239	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:13:53.545+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	3	http://localhost:8083
240	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:14:12.173+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	7	http://localhost:8082
241	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:14:12.199+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	4	http://localhost:8082
242	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:14:40.467+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	4	http://localhost:8082
243	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:14:47.56+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	4	http://localhost:8082
244	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:12.847+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
245	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:12.863+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
246	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:12.863+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
247	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:12.864+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
248	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:12.88+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
249	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:41.799+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	3	http://localhost:8082
250	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:41.825+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	6	http://localhost:8082
251	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:53.959+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	6	http://localhost:8082
252	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:55.097+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	6	http://localhost:8082
253	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:06.317+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
254	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:06.319+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
255	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:06.32+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
256	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:06.324+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
257	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:06.336+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
258	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:22:51.497+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8055
259	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:30:25.819+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8082
260	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:31:37.58+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	9	http://localhost:8083
261	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:32:58.05+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	7	http://localhost:8082
262	create	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:32:58.068+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	order_items	9	http://localhost:8082
263	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:32:58.086+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	9	http://localhost:8082
264	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:33:24.686+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
265	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:33:24.687+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
266	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:33:24.688+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
267	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:33:24.691+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
268	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:33:24.712+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
269	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:34:25.089+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	inventory	9	http://localhost:8083
270	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:34:25.112+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	7	http://localhost:8083
271	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:34:42.112+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	7	http://localhost:8083
272	update	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:34:58.345+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	orders	7	http://localhost:8083
273	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 11:14:24.493+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
274	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 11:14:24.498+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
275	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 11:14:24.501+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
276	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 11:14:24.501+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
277	login	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 11:14:24.516+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	directus_users	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	http://localhost:8083
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url, versioning) FROM stdin;
inventory	inventory_2	Product inventory management	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
categories	category	Inventory categories	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
units	straighten	Measurement units	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
inventory_images	image	Images for inventory items	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
orders	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
order_items	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N	f
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
-- Data for Name: directus_extensions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_extensions (enabled, id, folder, source, bundle) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message, searchable) FROM stdin;
1	inventory	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
2	inventory	product_name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N	t
3	inventory	sku	\N	input	\N	\N	\N	f	f	3	half	\N	\N	\N	f	\N	\N	\N	t
4	inventory	quantity	\N	input	\N	\N	\N	f	f	4	half	\N	\N	\N	t	\N	\N	\N	t
5	inventory	price	\N	input	\N	\N	\N	f	f	5	half	\N	\N	\N	f	\N	\N	\N	t
6	inventory	category	\N	select-dropdown	{"choices":[{"text":"Electronics","value":"electronics"},{"text":"Clothing","value":"clothing"},{"text":"Food","value":"food"},{"text":"Other","value":"other"}]}	\N	\N	f	f	6	half	\N	\N	\N	f	\N	\N	\N	t
7	inventory	description	\N	input-multiline	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N	t
8	inventory	reorder_level	\N	input	\N	\N	\N	f	f	8	half	\N	\N	\N	f	\N	\N	\N	t
9	inventory	supplier	\N	input	\N	\N	\N	f	f	9	half	\N	\N	\N	f	\N	\N	\N	t
10	inventory	status	\N	select-dropdown	{"choices":[{"text":"In Stock","value":"in_stock"},{"text":"Low Stock","value":"low_stock"},{"text":"Out of Stock","value":"out_of_stock"}]}	\N	\N	f	f	10	half	\N	\N	\N	f	\N	\N	\N	t
11	inventory	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	11	half	\N	\N	\N	f	\N	\N	\N	t
12	inventory	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"}	user	\N	t	t	12	half	\N	\N	\N	f	\N	\N	\N	t
13	inventory	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	13	half	\N	\N	\N	f	\N	\N	\N	t
14	inventory	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	14	half	\N	\N	\N	f	\N	\N	\N	t
15	inventory	unit	\N	input	\N	\N	\N	f	f	15	half	\N	\N	\N	f	\N	\N	\N	t
16	categories	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
17	categories	name	\N	input	\N	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N	t
18	categories	description	\N	input-multiline	\N	\N	\N	f	f	3	full	\N	\N	\N	f	\N	\N	\N	t
19	categories	status	\N	select-dropdown	{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]}	\N	\N	f	f	4	half	\N	\N	\N	f	\N	\N	\N	t
20	categories	date_created	date-created	datetime	\N	datetime	\N	t	t	5	full	\N	\N	\N	f	\N	\N	\N	t
21	categories	date_updated	date-updated	datetime	\N	datetime	\N	t	t	6	full	\N	\N	\N	f	\N	\N	\N	t
22	units	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
23	units	name	\N	input	\N	\N	\N	f	f	2	half	\N	\N	\N	t	\N	\N	\N	t
24	units	abbreviation	\N	input	\N	\N	\N	f	f	3	half	\N	\N	\N	f	\N	\N	\N	t
25	units	status	\N	select-dropdown	{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]}	\N	\N	f	f	4	half	\N	\N	\N	f	\N	\N	\N	t
26	units	date_created	date-created	datetime	\N	datetime	\N	t	t	5	full	\N	\N	\N	f	\N	\N	\N	t
27	units	date_updated	date-updated	datetime	\N	datetime	\N	t	t	6	full	\N	\N	\N	f	\N	\N	\N	t
28	inventory_images	id	\N	numeric	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
29	inventory_images	inventory_id	m2o	select-dropdown-m2o	{"template":"{{product_name}}"}	\N	\N	f	f	2	full	\N	\N	\N	t	\N	\N	\N	t
30	inventory_images	directus_files_id	file	file-image	\N	\N	\N	f	f	3	full	\N	\N	\N	t	\N	\N	\N	t
31	inventory_images	date_created	date-created	datetime	\N	datetime	\N	t	t	4	full	\N	\N	\N	f	\N	\N	\N	t
32	orders	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
33	orders	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	2	half	\N	\N	\N	f	\N	\N	\N	t
34	orders	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
35	orders	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
36	orders	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
38	orders	customer_name	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N	t
39	orders	customer_email	\N	input	\N	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N	t
40	orders	customer_phone	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N	t
41	orders	shipping_address	\N	input-multiline	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N	t
42	orders	payment_method	\N	select-dropdown	{"choices":[{"text":"Cod","value":"cod"},{"text":"Gcash","value":"gcash"},{"text":"Bank Transfer","value":"bank_transfer"}]}	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N	t
43	orders	status	\N	select-dropdown	{"choices":[{"text":"Pending","value":"pending"},{"text":"Processed","value":"processed"},{"text":"On Delivery","value":"on_delivery"},{"text":"Completed","value":"completed"},{"text":"Cancelled","value":"cancelled"}]}	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N	t
44	orders	subtotal	\N	input	\N	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N	t
45	orders	shipping_fee	\N	input	\N	\N	\N	f	f	13	full	\N	\N	\N	f	\N	\N	\N	t
46	orders	total_amount	\N	input	\N	\N	\N	f	f	14	full	\N	\N	\N	f	\N	\N	\N	t
47	orders	notes	\N	input-multiline	\N	\N	\N	f	f	15	full	\N	\N	\N	f	\N	\N	\N	t
48	orders	user_id	\N	input	\N	\N	\N	f	f	16	full	\N	\N	\N	f	\N	\N	\N	t
49	order_items	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N	t
50	order_items	user_created	user-created	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	2	half	\N	\N	\N	f	\N	\N	\N	t
51	order_items	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N	t
52	order_items	user_updated	user-updated	select-dropdown-m2o	{"template":"{{avatar}} {{first_name}} {{last_name}}"}	user	\N	t	t	4	half	\N	\N	\N	f	\N	\N	\N	t
53	order_items	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	5	half	\N	\N	\N	f	\N	\N	\N	t
54	order_items	order_id	m2o	select-dropdown-m2o	{"template":"{{id}}"}	\N	\N	f	f	6	full	\N	\N	\N	f	\N	\N	\N	t
55	order_items	inventory_id	m2o	select-dropdown-m2o	{"template":"{{id}}"}	\N	\N	f	f	7	full	\N	\N	\N	f	\N	\N	\N	t
56	order_items	product_name	\N	input	\N	\N	\N	f	f	8	full	\N	\N	\N	f	\N	\N	\N	t
57	order_items	quantity	\N	input	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N	t
58	order_items	unit_price	\N	input	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N	t
59	order_items	subtotal	\N	input	\N	\N	\N	f	f	11	full	\N	\N	\N	f	\N	\N	\N	t
60	orders	items	o2m	list-o2m	\N	\N	\N	f	f	17	full	\N	\N	\N	f	\N	\N	\N	t
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, created_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata, focal_point_x, focal_point_y, tus_id, tus_data, uploaded_on) FROM stdin;
bf638d96-846b-47a5-b56b-5fba4d2edb43	local	bf638d96-846b-47a5-b56b-5fba4d2edb43.jpg	609072341_3404171466427865_5847515573298134334_n.jpg	609072341 3404171466427865 5847515573298134334 N	image/jpeg	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:15.966+00	\N	2026-01-17 21:57:15.976+00	\N	88191	828	979	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-17 21:57:15.976+00
a5e977e2-01df-43d0-83c7-13f998bec552	local	a5e977e2-01df-43d0-83c7-13f998bec552.jpg	609548020_1577630546698910_5432013685712143043_n.jpg	609548020 1577630546698910 5432013685712143043 N	image/jpeg	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.002+00	\N	2026-01-17 21:57:16.008+00	\N	94462	651	982	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-17 21:57:16.007+00
49cf37b3-efbd-4c09-85df-ac2b2b9dc16f	local	49cf37b3-efbd-4c09-85df-ac2b2b9dc16f.jpg	609654698_754497020468137_2028853701521916783_n.jpg	609654698 754497020468137 2028853701521916783 N	image/jpeg	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.028+00	\N	2026-01-17 21:57:16.032+00	\N	89069	800	1005	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-17 21:57:16.032+00
bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782	local	bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782.jpg	609729462_4398171847176726_140824536903193403_n.jpg	609729462 4398171847176726 140824536903193403 N	image/jpeg	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.051+00	\N	2026-01-17 21:57:16.055+00	\N	83206	806	972	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-17 21:57:16.055+00
c01a1aa0-993e-4a1c-8676-4ec30cb69811	local	c01a1aa0-993e-4a1c-8676-4ec30cb69811.jpg	609778310_4301969070036970_6234113746221906471_n.jpg	609778310 4301969070036970 6234113746221906471 N	image/jpeg	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 21:57:16.075+00	\N	2026-01-17 21:57:16.08+00	\N	94851	828	998	\N	\N	\N	\N	\N	{}	\N	\N	\N	\N	2026-01-17 21:57:16.079+00
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2026-01-17 19:19:33.311412+00
20201029A	Remove System Relations	2026-01-17 19:19:33.314117+00
20201029B	Remove System Collections	2026-01-17 19:19:33.316501+00
20201029C	Remove System Fields	2026-01-17 19:19:33.320318+00
20201105A	Add Cascade System Relations	2026-01-17 19:19:33.328771+00
20201105B	Change Webhook URL Type	2026-01-17 19:19:33.332454+00
20210225A	Add Relations Sort Field	2026-01-17 19:19:33.334763+00
20210304A	Remove Locked Fields	2026-01-17 19:19:33.335523+00
20210312A	Webhooks Collections Text	2026-01-17 19:19:33.3377+00
20210331A	Add Refresh Interval	2026-01-17 19:19:33.338748+00
20210415A	Make Filesize Nullable	2026-01-17 19:19:33.340835+00
20210416A	Add Collections Accountability	2026-01-17 19:19:33.341962+00
20210422A	Remove Files Interface	2026-01-17 19:19:33.342562+00
20210506A	Rename Interfaces	2026-01-17 19:19:33.348234+00
20210510A	Restructure Relations	2026-01-17 19:19:33.351987+00
20210518A	Add Foreign Key Constraints	2026-01-17 19:19:33.354418+00
20210519A	Add System Fk Triggers	2026-01-17 19:19:33.360202+00
20210521A	Add Collections Icon Color	2026-01-17 19:19:33.360803+00
20210525A	Add Insights	2026-01-17 19:19:33.365468+00
20210608A	Add Deep Clone Config	2026-01-17 19:19:33.366113+00
20210626A	Change Filesize Bigint	2026-01-17 19:19:33.369886+00
20210716A	Add Conditions to Fields	2026-01-17 19:19:33.370563+00
20210721A	Add Default Folder	2026-01-17 19:19:33.372068+00
20210802A	Replace Groups	2026-01-17 19:19:33.373478+00
20210803A	Add Required to Fields	2026-01-17 19:19:33.374118+00
20210805A	Update Groups	2026-01-17 19:19:33.375603+00
20210805B	Change Image Metadata Structure	2026-01-17 19:19:33.376804+00
20210811A	Add Geometry Config	2026-01-17 19:19:33.377505+00
20210831A	Remove Limit Column	2026-01-17 19:19:33.378076+00
20210903A	Add Auth Provider	2026-01-17 19:19:33.381934+00
20210907A	Webhooks Collections Not Null	2026-01-17 19:19:33.383548+00
20210910A	Move Module Setup	2026-01-17 19:19:33.384309+00
20210920A	Webhooks URL Not Null	2026-01-17 19:19:33.385906+00
20210924A	Add Collection Organization	2026-01-17 19:19:33.387545+00
20210927A	Replace Fields Group	2026-01-17 19:19:33.390232+00
20210927B	Replace M2M Interface	2026-01-17 19:19:33.390843+00
20210929A	Rename Login Action	2026-01-17 19:19:33.391392+00
20211007A	Update Presets	2026-01-17 19:19:33.393062+00
20211009A	Add Auth Data	2026-01-17 19:19:33.393672+00
20211016A	Add Webhook Headers	2026-01-17 19:19:33.394307+00
20211103A	Set Unique to User Token	2026-01-17 19:19:33.395357+00
20211103B	Update Special Geometry	2026-01-17 19:19:33.396168+00
20211104A	Remove Collections Listing	2026-01-17 19:19:33.396948+00
20211118A	Add Notifications	2026-01-17 19:19:33.400744+00
20211211A	Add Shares	2026-01-17 19:19:33.404929+00
20211230A	Add Project Descriptor	2026-01-17 19:19:33.405556+00
20220303A	Remove Default Project Color	2026-01-17 19:19:33.407216+00
20220308A	Add Bookmark Icon and Color	2026-01-17 19:19:33.407891+00
20220314A	Add Translation Strings	2026-01-17 19:19:33.408465+00
20220322A	Rename Field Typecast Flags	2026-01-17 19:19:33.40976+00
20220323A	Add Field Validation	2026-01-17 19:19:33.410376+00
20220325A	Fix Typecast Flags	2026-01-17 19:19:33.411892+00
20220325B	Add Default Language	2026-01-17 19:19:33.413913+00
20220402A	Remove Default Value Panel Icon	2026-01-17 19:19:33.41559+00
20220429A	Add Flows	2026-01-17 19:19:33.42303+00
20220429B	Add Color to Insights Icon	2026-01-17 19:19:33.423668+00
20220429C	Drop Non Null From IP of Activity	2026-01-17 19:19:33.424227+00
20220429D	Drop Non Null From Sender of Notifications	2026-01-17 19:19:33.424856+00
20220614A	Rename Hook Trigger to Event	2026-01-17 19:19:33.425387+00
20220801A	Update Notifications Timestamp Column	2026-01-17 19:19:33.427062+00
20220802A	Add Custom Aspect Ratios	2026-01-17 19:19:33.427648+00
20220826A	Add Origin to Accountability	2026-01-17 19:19:33.428483+00
20230401A	Update Material Icons	2026-01-17 19:19:33.430201+00
20230525A	Add Preview Settings	2026-01-17 19:19:33.430738+00
20230526A	Migrate Translation Strings	2026-01-17 19:19:33.433873+00
20230721A	Require Shares Fields	2026-01-17 19:19:33.43533+00
20230823A	Add Content Versioning	2026-01-17 19:19:33.440607+00
20230927A	Themes	2026-01-17 19:19:33.443735+00
20231009A	Update CSV Fields to Text	2026-01-17 19:19:33.445072+00
20231009B	Update Panel Options	2026-01-17 19:19:33.445724+00
20231010A	Add Extensions	2026-01-17 19:19:33.446942+00
20231215A	Add Focalpoints	2026-01-17 19:19:33.447583+00
20240122A	Add Report URL Fields	2026-01-17 19:19:33.448198+00
20240204A	Marketplace	2026-01-17 19:19:33.453676+00
20240305A	Change Useragent Type	2026-01-17 19:19:33.45625+00
20240311A	Deprecate Webhooks	2026-01-17 19:19:33.459341+00
20240422A	Public Registration	2026-01-17 19:19:33.460707+00
20240515A	Add Session Window	2026-01-17 19:19:33.461333+00
20240701A	Add Tus Data	2026-01-17 19:19:33.46194+00
20240716A	Update Files Date Fields	2026-01-17 19:19:33.463639+00
20240806A	Permissions Policies	2026-01-17 19:19:33.473678+00
20240817A	Update Icon Fields Length	2026-01-17 19:19:33.478658+00
20240909A	Separate Comments	2026-01-17 19:19:33.481956+00
20240909B	Consolidate Content Versioning	2026-01-17 19:19:33.482599+00
20240924A	Migrate Legacy Comments	2026-01-17 19:19:33.483966+00
20240924B	Populate Versioning Deltas	2026-01-17 19:19:33.485685+00
20250224A	Visual Editor	2026-01-17 19:19:33.486517+00
20250609A	License Banner	2026-01-17 19:19:33.487752+00
20250613A	Add Project ID	2026-01-17 19:19:33.490931+00
20250718A	Add Direction	2026-01-17 19:19:33.491572+00
20250813A	Add MCP	2026-01-17 19:19:33.492573+00
20251012A	Add Field Searchable	2026-01-17 19:19:33.493299+00
20251014A	Add Project Owner	2026-01-17 19:19:33.509984+00
20251028A	Add Retention Indexes	2026-01-17 19:19:33.530709+00
20251103A	Add AI Settings	2026-01-17 19:19:33.531711+00
20251224A	Remove Webhooks	2026-01-17 19:19:33.532815+00
20260113A	Add Revisions Index	2026-01-17 19:19:33.53976+00
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
\.


--
-- Data for Name: directus_policies; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_policies (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
abf8a154-5b1c-4a46-ac9c-7300570f4f17	$t:public_label	public	$t:public_description	\N	f	f	f
d9ad76d0-9756-4436-b4f1-bf6c1b2927c2	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
1	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N	inventory	\N	\N	{"tabular":{"fields":["price","product_name","quantity","sku","category","description","reorder_level","supplier","status","user_created","user_updated","date_updated","date_created","unit","id"]}}	\N	\N	\N	bookmark	\N
2	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N	orders	\N	\N	{"tabular":{"fields":["customer_email","customer_name","customer_phone","shipping_address","user_id","items"]}}	\N	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	inventory_images	inventory_id	inventory	\N	\N	\N	\N	\N	nullify
2	orders	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
3	orders	user_created	directus_users	\N	\N	\N	\N	\N	nullify
4	order_items	user_created	directus_users	\N	\N	\N	\N	\N	nullify
5	order_items	user_updated	directus_users	\N	\N	\N	\N	\N	nullify
7	order_items	inventory_id	inventory	\N	\N	\N	\N	\N	nullify
6	order_items	order_id	orders	items	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent, version) FROM stdin;
1	3	directus_settings	1	{"id":1,"project_name":"Directus","project_url":null,"project_color":"#6644FF","project_logo":null,"public_foreground":null,"public_background":null,"public_note":null,"auth_login_attempts":25,"auth_password_policy":null,"storage_asset_transform":"all","storage_asset_presets":null,"custom_css":null,"storage_default_folder":null,"basemaps":null,"mapbox_key":null,"module_bar":null,"project_descriptor":null,"default_language":"en-US","custom_aspect_ratios":null,"public_favicon":null,"default_appearance":"auto","default_theme_light":null,"theme_light_overrides":null,"default_theme_dark":null,"theme_dark_overrides":null,"report_error_url":null,"report_bug_url":null,"report_feature_url":null,"public_registration":false,"public_registration_verify_email":true,"public_registration_role":null,"public_registration_email_filter":null,"visual_editor_urls":null,"project_id":"019bcd66-0372-722b-a91b-b3380385e2b7","mcp_enabled":false,"mcp_allow_deletes":false,"mcp_prompts_collection":null,"mcp_system_prompt_enabled":true,"mcp_system_prompt":null,"project_owner":"admin@example.com","project_usage":"personal","org_name":null,"product_updates":true,"project_status":null,"ai_openai_api_key":null,"ai_anthropic_api_key":null,"ai_system_prompt":null}	{"project_owner":"admin@example.com","project_usage":"personal","org_name":null,"product_updates":true,"project_status":null}	\N	\N
2	5	directus_fields	1	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"inventory"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"inventory"}	\N	\N
3	6	directus_collections	inventory	{"collection":"inventory","icon":"inventory_2","note":"Product inventory management"}	{"collection":"inventory","icon":"inventory_2","note":"Product inventory management"}	\N	\N
4	7	directus_fields	2	{"sort":2,"interface":"input","required":true,"width":"full","collection":"inventory","field":"product_name"}	{"sort":2,"interface":"input","required":true,"width":"full","collection":"inventory","field":"product_name"}	\N	\N
5	8	directus_fields	3	{"sort":3,"interface":"input","width":"half","collection":"inventory","field":"sku"}	{"sort":3,"interface":"input","width":"half","collection":"inventory","field":"sku"}	\N	\N
6	9	directus_fields	4	{"sort":4,"interface":"input","required":true,"width":"half","collection":"inventory","field":"quantity"}	{"sort":4,"interface":"input","required":true,"width":"half","collection":"inventory","field":"quantity"}	\N	\N
7	10	directus_fields	5	{"sort":5,"interface":"input","width":"half","collection":"inventory","field":"price"}	{"sort":5,"interface":"input","width":"half","collection":"inventory","field":"price"}	\N	\N
8	11	directus_fields	6	{"sort":6,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Electronics","value":"electronics"},{"text":"Clothing","value":"clothing"},{"text":"Food","value":"food"},{"text":"Other","value":"other"}]},"collection":"inventory","field":"category"}	{"sort":6,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Electronics","value":"electronics"},{"text":"Clothing","value":"clothing"},{"text":"Food","value":"food"},{"text":"Other","value":"other"}]},"collection":"inventory","field":"category"}	\N	\N
9	12	directus_fields	7	{"sort":7,"interface":"input-multiline","width":"full","collection":"inventory","field":"description"}	{"sort":7,"interface":"input-multiline","width":"full","collection":"inventory","field":"description"}	\N	\N
10	13	directus_fields	8	{"sort":8,"interface":"input","width":"half","collection":"inventory","field":"reorder_level"}	{"sort":8,"interface":"input","width":"half","collection":"inventory","field":"reorder_level"}	\N	\N
11	14	directus_fields	9	{"sort":9,"interface":"input","width":"half","collection":"inventory","field":"supplier"}	{"sort":9,"interface":"input","width":"half","collection":"inventory","field":"supplier"}	\N	\N
12	15	directus_fields	10	{"sort":10,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"In Stock","value":"in_stock"},{"text":"Low Stock","value":"low_stock"},{"text":"Out of Stock","value":"out_of_stock"}]},"collection":"inventory","field":"status"}	{"sort":10,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"In Stock","value":"in_stock"},{"text":"Low Stock","value":"low_stock"},{"text":"Out of Stock","value":"out_of_stock"}]},"collection":"inventory","field":"status"}	\N	\N
13	16	inventory	1	{"product_name":"Laptop","sku":"LAP-001","quantity":50,"price":999.99,"category":"electronics","description":"15-inch laptop with 16GB RAM","reorder_level":10,"supplier":"TechSupply Co","status":"in_stock"}	{"product_name":"Laptop","sku":"LAP-001","quantity":50,"price":999.99,"category":"electronics","description":"15-inch laptop with 16GB RAM","reorder_level":10,"supplier":"TechSupply Co","status":"in_stock"}	\N	\N
14	17	directus_fields	11	{"sort":11,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"user_created"}	{"sort":11,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"user_created"}	\N	\N
15	18	directus_fields	12	{"sort":12,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"user_updated"}	{"sort":12,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar.$thumbnail}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"user_updated"}	\N	\N
16	19	directus_fields	13	{"sort":13,"special":["date-created"],"interface":"datetime","display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"date_created"}	{"sort":13,"special":["date-created"],"interface":"datetime","display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"date_created"}	\N	\N
17	20	directus_fields	14	{"sort":14,"special":["date-updated"],"interface":"datetime","display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"date_updated"}	{"sort":14,"special":["date-updated"],"interface":"datetime","display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"width":"half","collection":"inventory","field":"date_updated"}	\N	\N
18	21	inventory	2	{"product_name":"Keyboard","sku":"KEY-001","quantity":75,"price":49.99,"category":"electronics","status":"in_stock"}	{"product_name":"Keyboard","sku":"KEY-001","quantity":75,"price":49.99,"category":"electronics","status":"in_stock"}	\N	\N
47	64	units	4	{"name":"yards","abbreviation":"yd","status":"active"}	{"name":"yards","abbreviation":"yd","status":"active"}	\N	\N
48	65	units	5	{"name":"rolls","abbreviation":"rol","status":"active"}	{"name":"rolls","abbreviation":"rol","status":"active"}	\N	\N
19	22	inventory	2	{"id":2,"product_name":"Keyboard","sku":"KEY-001","quantity":80,"price":"49.99000","category":"electronics","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:39:25.826Z","date_updated":"2026-01-17T19:40:26.781Z"}	{"quantity":80,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-17T19:40:26.781Z"}	\N	\N
20	24	directus_fields	15	{"sort":15,"interface":"input","width":"half","collection":"inventory","field":"unit"}	{"sort":15,"interface":"input","width":"half","collection":"inventory","field":"unit"}	\N	\N
21	28	inventory	3	{"product_name":"Silk Fabric (Red)","quantity":30,"price":1500,"category":"Fabric","unit":"meters","status":"in_stock"}	{"product_name":"Silk Fabric (Red)","quantity":30,"price":1500,"category":"Fabric","unit":"meters","status":"in_stock"}	\N	\N
22	29	inventory	4	{"product_name":"Cotton Fabric (White)","quantity":25,"price":800,"category":"Fabric","unit":"meters","status":"in_stock"}	{"product_name":"Cotton Fabric (White)","quantity":25,"price":800,"category":"Fabric","unit":"meters","status":"in_stock"}	\N	\N
23	30	inventory	5	{"product_name":"Velvet Fabric (Black)","quantity":15,"price":2000,"category":"Fabric","unit":"meters","status":"in_stock"}	{"product_name":"Velvet Fabric (Black)","quantity":15,"price":2000,"category":"Fabric","unit":"meters","status":"in_stock"}	\N	\N
24	31	inventory	6	{"product_name":"Cotton Thread (Black)","quantity":50,"price":50,"category":"Thread","unit":"spools","status":"in_stock"}	{"product_name":"Cotton Thread (Black)","quantity":50,"price":50,"category":"Thread","unit":"spools","status":"in_stock"}	\N	\N
25	32	inventory	7	{"product_name":"Buttons (Gold)","quantity":120,"price":25,"category":"Accessories","unit":"pieces","status":"in_stock"}	{"product_name":"Buttons (Gold)","quantity":120,"price":25,"category":"Accessories","unit":"pieces","status":"in_stock"}	\N	\N
26	37	inventory	8	{"product_name":"asd","category":"dsa","quantity":12,"unit":"asd","price":"12332","status":"in_stock"}	{"product_name":"asd","category":"dsa","quantity":12,"unit":"asd","price":"12332","status":"in_stock"}	\N	\N
27	41	directus_fields	16	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"categories"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"categories"}	\N	\N
28	42	directus_collections	categories	{"collection":"categories","icon":"category","note":"Inventory categories"}	{"collection":"categories","icon":"category","note":"Inventory categories"}	\N	\N
29	44	directus_fields	17	{"sort":2,"interface":"input","required":true,"width":"full","collection":"categories","field":"name"}	{"sort":2,"interface":"input","required":true,"width":"full","collection":"categories","field":"name"}	\N	\N
30	45	directus_fields	18	{"sort":3,"interface":"input-multiline","width":"full","collection":"categories","field":"description"}	{"sort":3,"interface":"input-multiline","width":"full","collection":"categories","field":"description"}	\N	\N
31	46	directus_fields	19	{"sort":4,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]},"collection":"categories","field":"status"}	{"sort":4,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]},"collection":"categories","field":"status"}	\N	\N
32	47	directus_fields	20	{"sort":5,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"categories","field":"date_created"}	{"sort":5,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"categories","field":"date_created"}	\N	\N
33	48	directus_fields	21	{"sort":6,"special":["date-updated"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"categories","field":"date_updated"}	{"sort":6,"special":["date-updated"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"categories","field":"date_updated"}	\N	\N
34	50	directus_fields	22	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"units"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"units"}	\N	\N
35	51	directus_collections	units	{"collection":"units","icon":"straighten","note":"Measurement units"}	{"collection":"units","icon":"straighten","note":"Measurement units"}	\N	\N
36	52	directus_fields	23	{"sort":2,"interface":"input","required":true,"width":"half","collection":"units","field":"name"}	{"sort":2,"interface":"input","required":true,"width":"half","collection":"units","field":"name"}	\N	\N
37	53	directus_fields	24	{"sort":3,"interface":"input","width":"half","collection":"units","field":"abbreviation"}	{"sort":3,"interface":"input","width":"half","collection":"units","field":"abbreviation"}	\N	\N
38	54	directus_fields	25	{"sort":4,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]},"collection":"units","field":"status"}	{"sort":4,"interface":"select-dropdown","width":"half","options":{"choices":[{"text":"Active","value":"active"},{"text":"Inactive","value":"inactive"}]},"collection":"units","field":"status"}	\N	\N
39	55	directus_fields	26	{"sort":5,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"units","field":"date_created"}	{"sort":5,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"units","field":"date_created"}	\N	\N
40	56	directus_fields	27	{"sort":6,"special":["date-updated"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"units","field":"date_updated"}	{"sort":6,"special":["date-updated"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"units","field":"date_updated"}	\N	\N
41	58	categories	1	{"name":"Fabric","description":"Various types of fabric materials","status":"active"}	{"name":"Fabric","description":"Various types of fabric materials","status":"active"}	\N	\N
42	59	categories	2	{"name":"Thread","description":"Sewing threads and yarns","status":"active"}	{"name":"Thread","description":"Sewing threads and yarns","status":"active"}	\N	\N
43	60	categories	3	{"name":"Accessories","description":"Buttons, zippers, and other accessories","status":"active"}	{"name":"Accessories","description":"Buttons, zippers, and other accessories","status":"active"}	\N	\N
44	61	units	1	{"name":"meters","abbreviation":"m","status":"active"}	{"name":"meters","abbreviation":"m","status":"active"}	\N	\N
45	62	units	2	{"name":"pieces","abbreviation":"pcs","status":"active"}	{"name":"pieces","abbreviation":"pcs","status":"active"}	\N	\N
46	63	units	3	{"name":"spools","abbreviation":"spl","status":"active"}	{"name":"spools","abbreviation":"spl","status":"active"}	\N	\N
49	71	directus_fields	28	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"inventory_images"}	{"sort":1,"hidden":true,"interface":"numeric","readonly":true,"field":"id","collection":"inventory_images"}	\N	\N
50	72	directus_collections	inventory_images	{"collection":"inventory_images","icon":"image","note":"Images for inventory items"}	{"collection":"inventory_images","icon":"image","note":"Images for inventory items"}	\N	\N
51	74	directus_fields	29	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{product_name}}"},"collection":"inventory_images","field":"inventory_id"}	{"sort":2,"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"options":{"template":"{{product_name}}"},"collection":"inventory_images","field":"inventory_id"}	\N	\N
52	75	directus_fields	30	{"sort":3,"interface":"file-image","special":["file"],"required":true,"collection":"inventory_images","field":"directus_files_id"}	{"sort":3,"interface":"file-image","special":["file"],"required":true,"collection":"inventory_images","field":"directus_files_id"}	\N	\N
53	76	directus_fields	31	{"sort":4,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"inventory_images","field":"date_created"}	{"sort":4,"special":["date-created"],"interface":"datetime","display":"datetime","readonly":true,"hidden":true,"collection":"inventory_images","field":"date_created"}	\N	\N
54	82	inventory	6	{"id":6,"product_name":"Cotton Thread (Black)","sku":null,"quantity":50,"price":"50.00000","category":"Thread","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.391Z","date_updated":"2026-01-17T21:37:25.438Z","unit":"spools"}	{"product_name":"Cotton Thread (Black)","quantity":50,"price":"50","category":"Thread","unit":"spools","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-17T21:37:25.438Z"}	\N	\N
55	104	inventory	6	{"id":6,"product_name":"Cotton Thread (Black)","sku":null,"quantity":50,"price":"50.00000","category":"Thread","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.391Z","date_updated":"2026-01-17T21:57:15.921Z","unit":"spools"}	{"product_name":"Cotton Thread (Black)","quantity":50,"price":"50","category":"Thread","unit":"spools","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-17T21:57:15.921Z"}	\N	\N
56	105	directus_files	bf638d96-846b-47a5-b56b-5fba4d2edb43	{"title":"609072341 3404171466427865 5847515573298134334 N","filename_download":"609072341_3404171466427865_5847515573298134334_n.jpg","type":"image/jpeg","storage":"local"}	{"title":"609072341 3404171466427865 5847515573298134334 N","filename_download":"609072341_3404171466427865_5847515573298134334_n.jpg","type":"image/jpeg","storage":"local"}	\N	\N
57	106	inventory_images	1	{"inventory_id":6,"directus_files_id":"bf638d96-846b-47a5-b56b-5fba4d2edb43"}	{"inventory_id":6,"directus_files_id":"bf638d96-846b-47a5-b56b-5fba4d2edb43"}	\N	\N
58	107	directus_files	a5e977e2-01df-43d0-83c7-13f998bec552	{"title":"609548020 1577630546698910 5432013685712143043 N","filename_download":"609548020_1577630546698910_5432013685712143043_n.jpg","type":"image/jpeg","storage":"local"}	{"title":"609548020 1577630546698910 5432013685712143043 N","filename_download":"609548020_1577630546698910_5432013685712143043_n.jpg","type":"image/jpeg","storage":"local"}	\N	\N
59	108	inventory_images	2	{"inventory_id":6,"directus_files_id":"a5e977e2-01df-43d0-83c7-13f998bec552"}	{"inventory_id":6,"directus_files_id":"a5e977e2-01df-43d0-83c7-13f998bec552"}	\N	\N
60	109	directus_files	49cf37b3-efbd-4c09-85df-ac2b2b9dc16f	{"title":"609654698 754497020468137 2028853701521916783 N","filename_download":"609654698_754497020468137_2028853701521916783_n.jpg","type":"image/jpeg","storage":"local"}	{"title":"609654698 754497020468137 2028853701521916783 N","filename_download":"609654698_754497020468137_2028853701521916783_n.jpg","type":"image/jpeg","storage":"local"}	\N	\N
61	110	inventory_images	3	{"inventory_id":6,"directus_files_id":"49cf37b3-efbd-4c09-85df-ac2b2b9dc16f"}	{"inventory_id":6,"directus_files_id":"49cf37b3-efbd-4c09-85df-ac2b2b9dc16f"}	\N	\N
62	111	directus_files	bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782	{"title":"609729462 4398171847176726 140824536903193403 N","filename_download":"609729462_4398171847176726_140824536903193403_n.jpg","type":"image/jpeg","storage":"local"}	{"title":"609729462 4398171847176726 140824536903193403 N","filename_download":"609729462_4398171847176726_140824536903193403_n.jpg","type":"image/jpeg","storage":"local"}	\N	\N
63	112	inventory_images	4	{"inventory_id":6,"directus_files_id":"bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782"}	{"inventory_id":6,"directus_files_id":"bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782"}	\N	\N
64	113	directus_files	c01a1aa0-993e-4a1c-8676-4ec30cb69811	{"title":"609778310 4301969070036970 6234113746221906471 N","filename_download":"609778310_4301969070036970_6234113746221906471_n.jpg","type":"image/jpeg","storage":"local"}	{"title":"609778310 4301969070036970 6234113746221906471 N","filename_download":"609778310_4301969070036970_6234113746221906471_n.jpg","type":"image/jpeg","storage":"local"}	\N	\N
65	114	inventory_images	5	{"inventory_id":6,"directus_files_id":"c01a1aa0-993e-4a1c-8676-4ec30cb69811"}	{"inventory_id":6,"directus_files_id":"c01a1aa0-993e-4a1c-8676-4ec30cb69811"}	\N	\N
66	137	inventory	6	{"id":6,"product_name":"Cotton Thread (Black)","sku":null,"quantity":50,"price":"50.00000","category":"Thread","description":"Manok manok nams","reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.391Z","date_updated":"2026-01-18T00:17:26.474Z","unit":"spools"}	{"product_name":"Cotton Thread (Black)","quantity":50,"price":"50","category":"Thread","description":"Manok manok nams","unit":"spools","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T00:17:26.474Z"}	\N	\N
67	138	directus_fields	32	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"orders"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"orders"}	\N	\N
68	139	directus_fields	33	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"orders"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"orders"}	\N	\N
91	163	directus_fields	54	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{id}}"},"collection":"order_items","field":"order_id"}	{"sort":6,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{id}}"},"collection":"order_items","field":"order_id"}	\N	\N
69	140	directus_fields	34	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"orders"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"orders"}	\N	\N
70	141	directus_fields	35	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"orders"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"orders"}	\N	\N
71	142	directus_fields	36	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"orders"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"orders"}	\N	\N
72	143	directus_collections	orders	{"singleton":false,"collection":"orders"}	{"singleton":false,"collection":"orders"}	\N	\N
73	144	directus_fields	37	{"sort":6,"interface":"input","special":null,"collection":"orders","field":"customer_name_"}	{"sort":6,"interface":"input","special":null,"collection":"orders","field":"customer_name_"}	\N	\N
74	146	directus_fields	38	{"sort":6,"interface":"input","special":null,"collection":"orders","field":"customer_name"}	{"sort":6,"interface":"input","special":null,"collection":"orders","field":"customer_name"}	\N	\N
75	147	directus_fields	39	{"sort":7,"interface":"input","special":null,"collection":"orders","field":"customer_email"}	{"sort":7,"interface":"input","special":null,"collection":"orders","field":"customer_email"}	\N	\N
76	148	directus_fields	40	{"sort":8,"interface":"input","special":null,"collection":"orders","field":"customer_phone"}	{"sort":8,"interface":"input","special":null,"collection":"orders","field":"customer_phone"}	\N	\N
77	149	directus_fields	41	{"sort":9,"interface":"input-multiline","special":null,"collection":"orders","field":"shipping_address"}	{"sort":9,"interface":"input-multiline","special":null,"collection":"orders","field":"shipping_address"}	\N	\N
78	150	directus_fields	42	{"sort":10,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Cod","value":"cod"},{"text":"Gcash","value":"gcash"},{"text":"Bank Transfer","value":"bank_transfer"}]},"collection":"orders","field":"payment_method"}	{"sort":10,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Cod","value":"cod"},{"text":"Gcash","value":"gcash"},{"text":"Bank Transfer","value":"bank_transfer"}]},"collection":"orders","field":"payment_method"}	\N	\N
79	151	directus_fields	43	{"sort":11,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Pending","value":"pending"},{"text":"Processed","value":"processed"},{"text":"On Delivery","value":"on_delivery"},{"text":"Completed","value":"completed"},{"text":"Cancelled","value":"cancelled"}]},"collection":"orders","field":"status"}	{"sort":11,"interface":"select-dropdown","special":null,"options":{"choices":[{"text":"Pending","value":"pending"},{"text":"Processed","value":"processed"},{"text":"On Delivery","value":"on_delivery"},{"text":"Completed","value":"completed"},{"text":"Cancelled","value":"cancelled"}]},"collection":"orders","field":"status"}	\N	\N
80	152	directus_fields	44	{"sort":12,"interface":"input","special":null,"collection":"orders","field":"subtotal"}	{"sort":12,"interface":"input","special":null,"collection":"orders","field":"subtotal"}	\N	\N
81	153	directus_fields	45	{"sort":13,"interface":"input","special":null,"collection":"orders","field":"shipping_fee"}	{"sort":13,"interface":"input","special":null,"collection":"orders","field":"shipping_fee"}	\N	\N
82	154	directus_fields	46	{"sort":14,"interface":"input","special":null,"collection":"orders","field":"total_amount"}	{"sort":14,"interface":"input","special":null,"collection":"orders","field":"total_amount"}	\N	\N
83	155	directus_fields	47	{"sort":15,"interface":"input-multiline","special":null,"collection":"orders","field":"notes"}	{"sort":15,"interface":"input-multiline","special":null,"collection":"orders","field":"notes"}	\N	\N
84	156	directus_fields	48	{"sort":16,"interface":"input","special":null,"collection":"orders","field":"user_id"}	{"sort":16,"interface":"input","special":null,"collection":"orders","field":"user_id"}	\N	\N
85	157	directus_fields	49	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"order_items"}	{"sort":1,"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"order_items"}	\N	\N
86	158	directus_fields	50	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"order_items"}	{"sort":2,"special":["user-created"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_created","collection":"order_items"}	\N	\N
87	159	directus_fields	51	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"order_items"}	{"sort":3,"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"order_items"}	\N	\N
88	160	directus_fields	52	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"order_items"}	{"sort":4,"special":["user-updated"],"interface":"select-dropdown-m2o","options":{"template":"{{avatar}} {{first_name}} {{last_name}}"},"display":"user","readonly":true,"hidden":true,"width":"half","field":"user_updated","collection":"order_items"}	\N	\N
89	161	directus_fields	53	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"order_items"}	{"sort":5,"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"order_items"}	\N	\N
90	162	directus_collections	order_items	{"singleton":false,"collection":"order_items"}	{"singleton":false,"collection":"order_items"}	\N	\N
92	164	directus_fields	55	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{id}}"},"collection":"order_items","field":"inventory_id"}	{"sort":7,"interface":"select-dropdown-m2o","special":["m2o"],"options":{"template":"{{id}}"},"collection":"order_items","field":"inventory_id"}	\N	\N
93	165	directus_fields	56	{"sort":8,"interface":"input","special":null,"collection":"order_items","field":"product_name"}	{"sort":8,"interface":"input","special":null,"collection":"order_items","field":"product_name"}	\N	\N
94	166	directus_fields	57	{"sort":9,"interface":"input","special":null,"collection":"order_items","field":"quantity"}	{"sort":9,"interface":"input","special":null,"collection":"order_items","field":"quantity"}	\N	\N
95	167	directus_fields	58	{"sort":10,"interface":"input","special":null,"collection":"order_items","field":"unit_price"}	{"sort":10,"interface":"input","special":null,"collection":"order_items","field":"unit_price"}	\N	\N
96	168	directus_fields	59	{"sort":11,"interface":"input","special":null,"collection":"order_items","field":"subtotal"}	{"sort":11,"interface":"input","special":null,"collection":"order_items","field":"subtotal"}	\N	\N
97	169	directus_fields	60	{"sort":17,"interface":"list-o2m","special":["o2m"],"collection":"orders","field":"items"}	{"sort":17,"interface":"list-o2m","special":["o2m"],"collection":"orders","field":"items"}	\N	\N
98	170	orders	1	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":2000,"shipping_fee":50,"total_amount":2050,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":2000,"shipping_fee":50,"total_amount":2050,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
99	171	order_items	1	{"order_id":1,"inventory_id":5,"product_name":"Velvet Fabric (Black)","quantity":1,"unit_price":2000,"subtotal":2000}	{"order_id":1,"inventory_id":5,"product_name":"Velvet Fabric (Black)","quantity":1,"unit_price":2000,"subtotal":2000}	\N	\N
100	182	orders	2	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":4500,"shipping_fee":50,"total_amount":4550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":4500,"shipping_fee":50,"total_amount":4550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
101	183	order_items	2	{"order_id":2,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":3,"unit_price":1500,"subtotal":4500}	{"order_id":2,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":3,"unit_price":1500,"subtotal":4500}	\N	\N
102	189	orders	2	{"id":2,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:16:48.178Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:17:00.388Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"4500.00","shipping_fee":"50.00","total_amount":"4550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[2]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:17:00.388Z"}	\N	\N
103	190	orders	2	{"id":2,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:16:48.178Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:17:30.550Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"on_delivery","subtotal":"4500.00","shipping_fee":"50.00","total_amount":"4550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[2]}	{"status":"on_delivery","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:17:30.550Z"}	\N	\N
104	191	orders	3	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":7500,"shipping_fee":50,"total_amount":7550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":7500,"shipping_fee":50,"total_amount":7550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
105	192	order_items	3	{"order_id":3,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":5,"unit_price":1500,"subtotal":7500}	{"order_id":3,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":5,"unit_price":1500,"subtotal":7500}	\N	\N
106	200	orders	2	{"id":2,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:16:48.178Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:24:54.872Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"completed","subtotal":"4500.00","shipping_fee":"50.00","total_amount":"4550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[2]}	{"status":"completed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:24:54.872Z"}	\N	\N
107	206	inventory	3	{"id":3,"product_name":"Silk Fabric (Red)","sku":null,"quantity":25,"price":"1500.00000","category":"Fabric","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.346Z","date_updated":"2026-01-18T02:27:12.095Z","unit":"meters"}	{"quantity":25,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:12.095Z"}	\N	\N
108	207	orders	3	{"id":3,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:20:41.705Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:12.135Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"7500.00","shipping_fee":"50.00","total_amount":"7550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[3]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:12.135Z"}	\N	\N
109	208	inventory	5	{"id":5,"product_name":"Velvet Fabric (Black)","sku":null,"quantity":14,"price":"2000.00000","category":"Fabric","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.379Z","date_updated":"2026-01-18T02:27:25.939Z","unit":"meters"}	{"quantity":14,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:25.939Z"}	\N	\N
110	209	orders	1	{"id":1,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T01:48:41.853Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:25.977Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"2000.00","shipping_fee":"50.00","total_amount":"2050.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[1]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:27:25.977Z"}	\N	\N
111	210	orders	4	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":125,"shipping_fee":50,"total_amount":175,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":125,"shipping_fee":50,"total_amount":175,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
112	211	order_items	4	{"order_id":4,"inventory_id":7,"product_name":"Buttons (Gold)","quantity":5,"unit_price":25,"subtotal":125}	{"order_id":4,"inventory_id":7,"product_name":"Buttons (Gold)","quantity":5,"unit_price":25,"subtotal":125}	\N	\N
113	217	orders	5	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":4250,"shipping_fee":50,"total_amount":4300,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":4250,"shipping_fee":50,"total_amount":4300,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
114	218	order_items	5	{"order_id":5,"inventory_id":5,"product_name":"Velvet Fabric (Black)","quantity":2,"unit_price":2000,"subtotal":4000}	{"order_id":5,"inventory_id":5,"product_name":"Velvet Fabric (Black)","quantity":2,"unit_price":2000,"subtotal":4000}	\N	\N
115	219	order_items	6	{"order_id":5,"inventory_id":6,"product_name":"Cotton Thread (Black)","quantity":3,"unit_price":50,"subtotal":150}	{"order_id":5,"inventory_id":6,"product_name":"Cotton Thread (Black)","quantity":3,"unit_price":50,"subtotal":150}	\N	\N
116	220	order_items	7	{"order_id":5,"inventory_id":7,"product_name":"Buttons (Gold)","quantity":4,"unit_price":25,"subtotal":100}	{"order_id":5,"inventory_id":7,"product_name":"Buttons (Gold)","quantity":4,"unit_price":25,"subtotal":100}	\N	\N
117	226	inventory	5	{"id":5,"product_name":"Velvet Fabric (Black)","sku":null,"quantity":12,"price":"2000.00000","category":"Fabric","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.379Z","date_updated":"2026-01-18T02:32:15.517Z","unit":"meters"}	{"quantity":12,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:32:15.517Z"}	\N	\N
118	227	inventory	6	{"id":6,"product_name":"Cotton Thread (Black)","sku":null,"quantity":47,"price":"50.00000","category":"Thread","description":"Manok manok nams","reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.391Z","date_updated":"2026-01-18T02:32:15.538Z","unit":"spools"}	{"quantity":47,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:32:15.538Z"}	\N	\N
119	228	inventory	7	{"id":7,"product_name":"Buttons (Gold)","sku":null,"quantity":116,"price":"25.00000","category":"Accessories","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.403Z","date_updated":"2026-01-18T02:32:15.559Z","unit":"pieces"}	{"quantity":116,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:32:15.559Z"}	\N	\N
120	229	orders	5	{"id":5,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:31:40.228Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:32:15.582Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"4250.00","shipping_fee":"50.00","total_amount":"4300.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[5,6,7]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T02:32:15.582Z"}	\N	\N
121	237	orders	6	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09632532951","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":15000,"shipping_fee":50,"total_amount":15050,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09632532951","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":15000,"shipping_fee":50,"total_amount":15050,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
122	238	order_items	8	{"order_id":6,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":10,"unit_price":1500,"subtotal":15000}	{"order_id":6,"inventory_id":3,"product_name":"Silk Fabric (Red)","quantity":10,"unit_price":1500,"subtotal":15000}	\N	\N
123	239	inventory	3	{"id":3,"product_name":"Silk Fabric (Red)","sku":null,"quantity":15,"price":"1500.00000","category":"Fabric","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.346Z","date_updated":"2026-01-18T11:13:53.543Z","unit":"meters"}	{"quantity":15,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:13:53.543Z"}	\N	\N
124	240	inventory	7	{"id":7,"product_name":"Buttons (Gold)","sku":null,"quantity":111,"price":"25.00000","category":"Accessories","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.403Z","date_updated":"2026-01-18T11:14:12.171Z","unit":"pieces"}	{"quantity":111,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:12.171Z"}	\N	\N
125	241	orders	4	{"id":4,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:28:07.616Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:12.198Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"125.00","shipping_fee":"50.00","total_amount":"175.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[4]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:12.198Z"}	\N	\N
126	242	orders	4	{"id":4,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:28:07.616Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:40.464Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"on_delivery","subtotal":"125.00","shipping_fee":"50.00","total_amount":"175.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[4]}	{"status":"on_delivery","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:40.464Z"}	\N	\N
127	243	orders	4	{"id":4,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T02:28:07.616Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:47.557Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"completed","subtotal":"125.00","shipping_fee":"50.00","total_amount":"175.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[4]}	{"status":"completed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:14:47.557Z"}	\N	\N
128	249	inventory	3	{"id":3,"product_name":"Silk Fabric (Red)","sku":null,"quantity":5,"price":"1500.00000","category":"Fabric","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-17T19:53:57.346Z","date_updated":"2026-01-18T11:15:41.798Z","unit":"meters"}	{"quantity":5,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:41.798Z"}	\N	\N
129	250	orders	6	{"id":6,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T11:13:53.498Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:41.823Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09632532951","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"15000.00","shipping_fee":"50.00","total_amount":"15050.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[8]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:41.823Z"}	\N	\N
130	251	orders	6	{"id":6,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T11:13:53.498Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:53.958Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09632532951","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"on_delivery","subtotal":"15000.00","shipping_fee":"50.00","total_amount":"15050.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[8]}	{"status":"on_delivery","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:53.958Z"}	\N	\N
131	252	orders	6	{"id":6,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-18T11:13:53.498Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:55.094Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09632532951","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"completed","subtotal":"15000.00","shipping_fee":"50.00","total_amount":"15050.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[8]}	{"status":"completed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-18T11:15:55.094Z"}	\N	\N
132	260	inventory	9	{"product_name":"manok","category":"Accessories","quantity":50,"unit":"meters","price":"500","description":null,"status":"in_stock"}	{"product_name":"manok","category":"Accessories","quantity":50,"unit":"meters","price":"500","description":null,"status":"in_stock"}	\N	\N
133	261	orders	7	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":2500,"shipping_fee":50,"total_amount":2550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	{"customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"pending","subtotal":2500,"shipping_fee":50,"total_amount":2550,"notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28"}	\N	\N
134	262	order_items	9	{"order_id":7,"inventory_id":9,"product_name":"manok","quantity":5,"unit_price":500,"subtotal":2500}	{"order_id":7,"inventory_id":9,"product_name":"manok","quantity":5,"unit_price":500,"subtotal":2500}	\N	\N
135	263	inventory	9	{"id":9,"product_name":"manok","sku":null,"quantity":45,"price":"500.00000","category":"Accessories","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-19T10:31:37.577Z","date_updated":"2026-01-19T10:32:58.085Z","unit":"meters"}	{"quantity":45,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:32:58.085Z"}	\N	\N
136	269	inventory	9	{"id":9,"product_name":"manok","sku":null,"quantity":40,"price":"500.00000","category":"Accessories","description":null,"reorder_level":10,"supplier":null,"status":"in_stock","user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-19T10:31:37.577Z","date_updated":"2026-01-19T10:34:25.087Z","unit":"meters"}	{"quantity":40,"user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:25.087Z"}	\N	\N
137	270	orders	7	{"id":7,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-19T10:32:58.045Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:25.111Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"processed","subtotal":"2500.00","shipping_fee":"50.00","total_amount":"2550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[9]}	{"status":"processed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:25.111Z"}	\N	\N
138	271	orders	7	{"id":7,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-19T10:32:58.045Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:42.111Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"on_delivery","subtotal":"2500.00","shipping_fee":"50.00","total_amount":"2550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[9]}	{"status":"on_delivery","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:42.111Z"}	\N	\N
139	272	orders	7	{"id":7,"user_created":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_created":"2026-01-19T10:32:58.045Z","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:58.342Z","customer_name":"Admin User","customer_email":"admin@example.com","customer_phone":"09564968599","shipping_address":"Sitio Sambat., Barangay Lalo","payment_method":"cod","status":"completed","subtotal":"2500.00","shipping_fee":"50.00","total_amount":"2550.00","notes":null,"user_id":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","items":[9]}	{"status":"completed","user_updated":"3eee48f9-2a9e-438c-ae27-d6eca2c3ec28","date_updated":"2026-01-19T10:34:58.342Z"}	\N	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, parent) FROM stdin;
677626c9-1d30-4155-9226-87162d9c9a10	Administrator	verified	$t:admin_description	\N
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin, next_token) FROM stdin;
2_QlYLKT8oEx0cjbD6Tm6XgLM3hQbs11W8PV9lkNMdVoNAwf_d4d1G9eKj61jwt6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:19:19.714+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
kjo3DovcMRAAoOiGcCOUDuwDMjhKM5oHn-qXS3tHoCFB-m7nJS5rLULwTYBOPxPq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:33:17.5+00	192.168.65.1	curl/8.7.1	\N	\N	\N
hEAUYazR7DnZnPIo6tfY43pKSSRxVDpLb8dYg5CfDeaP8Hn8-7YXEnhkdfN9wV77	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:19:37.062+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
3TFt7uHFJVsPZn2rbNRdx9xLjYgQzmeq2sFXTKMznTI3MR-xwnlPofAhCeUpzj6x	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:21:56.475+00	192.168.65.1	curl/8.7.1	\N	\N	\N
3yjEX2upTLFMXKXGsDKP7lZ9gOBWZtBaKj9mxmuhGrGYQSJl1MoxDxdVZvhwouJj	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:43:34.203+00	192.168.65.1	curl/8.7.1	\N	\N	\N
LpWn1RED3KKjwTRRtRlNRjJaB28bf9JwMQswPzRrOP6RZtPvVdU03GR2d_WDO5c3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:48:20.914+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
prqflkSAiJE7uKcv3WL7yTMb17-V0Vnm1vhgqrglZ4h2oiW58VzYp_3fi0rmnJxU	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:50:54.277+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
9Q3kUjH7GYC75ydj5eqYbdJ2qQ8ZZ4CwYMrvUhGIf9FfQ3sjsWYYxrMM1lAH7wmm	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:53:56.877+00	192.168.65.1	curl/8.7.1	\N	\N	\N
D0ZFZe6_L6TXKa3X_yug023GikmwO8SMCm1D3lx_ADgrgL6TvLfbV3MKHKW6LG0c	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:55:03.404+00	192.168.65.1	curl/8.7.1	\N	\N	\N
lnCOJ1aCwWSlPYRAx14KNFi0vmKH-sX7H5l1kaTH6Xwh1LEAMNWYrhcoiNCw56vf	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 19:57:37.867+00	192.168.65.1	curl/8.7.1	\N	\N	\N
Vax0J2qGEaeHcarT7QOE23vLS7Ts5Fdh_8j5Rt4vPBx8xlXlVq6Lit_tub3Ni8jO	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:24:22.665+00	192.168.65.1	curl/8.7.1	\N	\N	\N
bVAnKc7APY-VU55I5HkD7zqOrX_634wpjC_JMPmqChWAWya5mMi8gg8uKZp5PkDc	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:00:06.519+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Y-vYrTTa6CYn8sPl9boaBN5Nl6iz-lx8QHUpMgY0UGdgUv2XXXWuP_ox8LWtCdkq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:00:08.748+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
CYTdlCPhvlYlHtXvaosGUst4CBNh5VFVzYXnyvbwS0NuJFdDPQQma4pDR7KGDlQH	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:25:08.426+00	192.168.65.1	curl/8.7.1	\N	\N	\N
eoS-uWEmr2m1UGqBew9dtl8mEpoOEC_c7izPzfr4r9LToFtl2SALRfigf_cgY-Go	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:06:37.309+00	192.168.65.1	curl/8.7.1	\N	\N	\N
8d_EAEzdEMVvMZPOA9DmPRQCtVbCyUrRrwLmX_L_b8QiJP2AkLvrklQDNGS1rIaG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:08:10.197+00	192.168.65.1	curl/8.7.1	\N	\N	\N
VJGCQCdyAr0iQvWkMcgIXHy4i-iUHou_v81gmnlh18d5qL383MsxIBC2UoPtm8-O	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:08:35.177+00	192.168.65.1	curl/8.7.1	\N	\N	\N
PiGZmEhr3EoQm99mb4T1nD-C1hheEIPAYOiGfHbLx2-Mz1Pm580K_gcqELZVyoeh	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:09:31.958+00	192.168.65.1	curl/8.7.1	\N	\N	\N
A80Y4O-v5TgVyf4-s89msDlgfZD1Vce_Gd64S9m_v2YnA8FmCQC_zbNZVr6nP55I	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.166+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
PMjCOf9JsoJ04GVVscBdyl7RSZdqxg33c37QPrI4-GooMon1uKYEOQ4EkAlPYzrT	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:10:28.068+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
px1hq0wSFv87zr73_0_hiFWzYNvj0iYRckSqH7K0LOM-fxuzQ78NPrp7M6mbp6EY	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 20:17:11.518+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
AeVEgpvOwBsHnx_bedi_DEHo52uPGewf4oEcK4t2wIxZUCQo2E0M31YocpjTUadP	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:25:49.138+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
fTPkZT4POde71BB3Eh8X9NK1X8QztiZ7QyxEQ3U9NGxdm3PwGYwUS4ZWsx488zcO	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:25:49.139+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
WqEWYy1Bs5CqE4vGVZfIrjZGlIErTyiSxv-CQh0gph5bnwmScOAEt6Oz4CQZoBp7	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:25:49.139+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
vqgaHsZoFMau_o35tHvLVrie4e44pAFAOAqnb1Jff1dkylV5H5aQVTuIBC30hkj3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:39:05.902+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
ZEqlko1LSiAvMJ2WgDAmvwh6aUg7ZtVkwTpwN9fI2CVueMjIDnvsLoFLYXH75zW8	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:39:05.907+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Pnr_h88sF8aQU5YBokDreDNO48_5jXHlZ6fDulVosx6v4H6vBHTlkzoVY4gdKQIM	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:39:05.91+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Yp3zwF3baILVPRrsnEdVF_Ske-OqIMtZmdnrCFC0AcH3gv_ywev5idymze1kFACL	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.154+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
9lVYyogJGId7OtukdthvjheqG_QyzAA_vnvR-IWBbBs4HezBI6KkOHEDotddZd_Q	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.16+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
L2o8EQJf8bRtYTlyQXaonovP2qFmOmelmlUasGoWzbIXHOUe4IBRjMglDOyhSUNH	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.486+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Q4YPC0iQq7j38riUivXknlSXJ7VYx9naOmr_sOU6Ty1mXsBu7b-Jf4dLhVkgwfqq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.489+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
L3JnCZ2Eo2KuBXkFg1fmpTcrKSxGTEqINNcmWVl6bhYmNmqhoTBtY-LrE2G4Ahls	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:41:00.49+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
sc5Edj31PIcTbE_GdPSaVaZRiEIMDwc-X_VDwab3ZzOSPaw8gtyCCRyOFFryl8d4	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:45:57.349+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
m4VvY_OFZ63TWOyg4KVoCN0wDNC-jgBM8kNpMu1fBTGidmNZjmH2N87ddMH9UCE1	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:45:57.35+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
oVF3XaAr1VKHL7qW9235bb_lIbKrvQIHfebm4VQUXynQqLZvr_RGZiuMqWqFsnCr	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:45:57.351+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
wY9UTYtQRKgcDcdg2CvMnVgoIDJaJ9HZxe7iVsNU9TEVkHsImN2gCrIoShlz2Ouo	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:48:09.192+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
o_tTwIoo4bsvmD699msNJY74UO_vRL3Qccq2aiaONE7X9vxLtSLsJ7Z-TJRp1h6c	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:48:09.193+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
zVGD89KcH3YnrVnheh-HqT3BtS4esSUeOT85vg3kY5qmmC66m6xQ4AICyUFhlcWH	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:48:09.201+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
l7YI-4aoAurOYJFSEb-9zLl0Knjl8MgtJQ7Y4058jQu_WIq6V3LQLjW6cVEbE0h9	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:50:51.657+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
wQHP_PeuqHQ0rTyLf985E-uFoaOtjK0K4ywlB9HWOh6BYe6CbcRe8RWZh1Kvkelr	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:50:51.665+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
y5IGIVtsMw_t66hZV8lhyt5TjCM539J0ArSuS4GNdNwV1-nnFchX_q3GfTQ31K4v	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:50:51.667+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Ay-RMAGLYsa_7n9YisYnKVzlvNbPoVew75SULw7-HD_L-hRRG2XV5-rQ7fEufBQo	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:56:12.423+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
FpJLZKK2MvYLy5JXbZyTd4shquJN2T-n2-LsneSafAf-fj4jR4v18gnddwXwmPFi	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:56:12.43+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
6G0DZ1-anSDcHn3kJX48pt9La2kH2KqTs4PWKOb7Oha-8LCsaRlIPf4nEsi8e2op	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:56:12.432+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
iMkUL3bRKwcwAcbIXyqMdyLhsiAv8su54N3_U6ime9-h2aWZum0Zks5BxcBKeuPd	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:59:18.621+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
iQ-SQXJSZ2u91hPALOY307E4hCLIuM7i7PdCuOvMjv9aSfCwXWmcftvpuMAgh5xA	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:59:18.624+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
wPZgvwEhOBt2dGzVSoMM4dET-39xFGqxuVnu4WPOshQY8BaF_u6FfzbnePc0HyC_	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 21:59:18.628+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
fDSUVV6cK2MPzP4Gjo6QnGxFIlfH7rrpKHhE8bMSxe3YQbfJOhZmJM1mASlm6r6l	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:36:53.09+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
rl7rfh7LZulZTdIx4AYAviIjiQD-YpaT6R_apk8kRkH-_ijfiJD7vpKIERW1-zOq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:36:53.092+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
fhOg98_UaqXz-2ESd81J4ik7x7g39_1GZ0cXt88B-xu4jy5F4HALLV9j124oQ9TC	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:36:53.096+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
DB4ZndvlyH201hA_IOOZeJHEfZSzCWhMS8pdMCqQuXXd5zXUX1nuZ2rY6QoI8TKQ	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:56:21.145+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
mHE4D9PHub8wUB6uOn2VvcVBWwsFZrmU1DEELqRBe05l_Fujo6LLonO03WSEvdre	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:56:21.146+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
AJohfpfwkHdpPmu1AuAe7jbqUhrZ3RidQeA3Gs3-LzBtOHXl8GS0l-OxnD7bfkqO	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-24 22:56:21.147+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
nSK13e70vTf7bO2FXp3enS_qMcbYgPQPK1_smBAlq2trFjAWJFZjZ2LZ0KyzlXt6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:12:57.701+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
B-mwndErZnFDQlrpnNVUxlILlK-4xaDxTSQxlrocgVAIrXb9Nfzjw1l_3eiumbkQ	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:12:57.702+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
jC6Sxsky5Ilubr7XPfzqHhoeEEQA_nmTTDqpmCCo9xmA_obTTno-hRlrqv5PMqPt	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:08.182+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
dXi4tH4eZuGyaXto7w9_-hVMEze4WARb9_4eHOj_zm_g6yPEtyUx2zzs6CffgcXK	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:08.182+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
SnRUrfr6U5fCUHWXNZB4_V8m8N_esnmLk8jb6t76T760KviTiQOd1X05AVhOPIt7	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:12:57.703+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
NwI1WusIh72joEU7m9LN-R8I6Nn67wHAyZSwXIWeB1MtQKUz7WF8AkTCgDYkxB2D	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:08.182+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Cdbtztp33CyhHk1msXaztyG_oclAtuTdDmerWaKx5eL2AWmQTcq6OFRk_VeMYd7D	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:14.218+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
0uSBg7oLP_m8hmp4YRjh28TXHT1_a82RGx76JfI3Nu5ONI9uNjRFfEpoPHRG8UhQ	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:14.219+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
nLP7G_WA_lvlTia-e48E7RXoXSdDaOPhWtROI-QS3LOJ7kiZtU1og-ydrP7spj5i	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:14:05.016+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
pB2GfCQLArHq42JhecM8XIj7omFTwynJ-Zg10JmwoSWEq2Hsz3dSUhPM5NuK8Xgg	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:13:14.222+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
rlGKDFYehL-6qeUjBl9kY6YuNXQmlQ-3e4jK2nqJTC3xyrRJaNSjzkn_rs5Sl0ir	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:14:05.018+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
GMhiRMCOGBQg-XB5m_WqphJ0XGah3kLG8GMTMlwxhN0TSwxKzDIYVIM3OyemYDzG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 00:14:05.018+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
hJxIFfbnFBA5PiKeYsf_lbovblC51wYfRpJ3BpjTK75SD3jVlYwbEDQqcowR9mZM	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:16:56.09+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
sw6rgImpbbm5wcKZuJSzCu5kK5IKjSAEvTap8kNlmAYsA7I1tp8oFfl8PG_BboEd	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:03:26.976+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
ILLgkze7KJ3YkVsW2tY_xwSIlygQztK9VF5-lUv7XRAkozMfpLFKzzSurVd3b7bq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:03:26.978+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
bltqR6cu0iF9RE5K8eLdnjPA90VHApQutonzAk0gG1fry0fgwZ5QP-7eP39cR52x	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:03:26.979+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
cMnWuLbhUPqz1AIXgxiG65mN_-D5DAxYHobg9TUvIlG6efGLetEabIcbuXYbmO9w	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:07:24.932+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
evXoCLcMTMgm7NCNcGJ01g9M2RC5X0Igh1U1SRhWz5Ew5QG2wtYjVkz2Y7iClMS7	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:07:24.932+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
A00_r_z-2wPs1WbvPksk01mbFMe1rbfyP9qCleSpFHkYVkvJQqLdOTUmItl6u3Mj	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:14:19.614+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
UmK0aswKs6RaW8psc7eZtd3YnSW-kEvQyGHCi5k6xtjKYjXv6LiVUD4P1MLAKQWs	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:14:19.633+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
G7hYn5TCkc23cmDfoTQ43yUWWwF-oRFjERCzlkDm_xiBIqE6-6fwi6_FVZHaYLl_	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:14:19.636+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
W-w4QV9WbIOSysNQe8KWdPLVK5NaXLnARHdP3PewcjHoKQ7StIrsf0H4Je45FmMQ	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:14:19.637+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
JjB6B6NCMYPlDG_qboHNAntyKIUHJEO_H1hNqdqQN_Potmk2_wgYGFTDHH9yttGe	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:14:19.656+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
GOjJfjc2iHLjC-M4-lS92Dgawtv6Cj_bp3N91eYlN_1ClRgtwy8uwMd1zn1_pMPN	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:16:56.069+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
GZwsOn3OuyQoZMSQS5XwrIDllvWN_ICnuJTevPy2bV8Rjy7AAyVngaMoZbaRLxl6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:16:56.08+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
BJmZJlohmKmH_2Sc0tr7T-DIVWkWDs20VjOS4eOYUn2ok58llChLzmtYNIT4vFl3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:16:56.088+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
cbN--uw87nfADXMVWPph_JvvUXLDcZs3Azpc6RYbNCZ2B6h7ohmLFtPUtoV0dU26	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:16:56.109+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
SALed5MK0qBkK6ktXDkFEO66ziymn95LbLOrWBqlD_mJElNtXogaoswxBPpa6yVD	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:22:47.037+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
qt5qQZNcMl2LWlHYbnxXgAVMnpvKW5JqmD8PLY7LWb8v9mP7ESk80tGtTA10024D	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:22:47.069+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
UolkZyzFWEWw6E8_BFM7DYrdbejKoR3CcYrRlai--QjrZRTsjtcihvSMT9zJVKYk	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:22:47.069+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
_uzqDWzP-IwZk5ra4q7damhmn24mQhEZbthEtdI4hW0Un3s-3QFkg8gF7meUt9ZC	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:22:47.071+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
3uV8HRUzMjVWJ3MjecaumvcZdyvGmDk45Rdfz_FLKO3QgmzEc7a0f-9HGGSgclPB	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:22:47.092+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
dHxxIMcCiFGdFyXEN4sdpfVQ46AzA7pkVXDCM-hlTPElkNa_9IgixDC_FeS2iWVT	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:23:38.353+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
Zml8vsFA7PHLOjqJsvYQvVMlTDJQ1SHDkRgMx9HWWSgVP3RPbSM5gePGGfkj5yy3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:23:38.36+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
ar75PDLsD_Qlle6UpYEKak2VMeVrL92rX_iNXPSd2AfqsoA_7jetBLkV3D8SfVlX	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:27:04.318+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
w78jp9xjsQ1i-TYIPqyEfFRuVVVEVg3H_2t9l-oKx-1Aj9o5FiwlwY-Gv0SBjfRG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:27:04.33+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
ee62sKmYiKtW43YexzJ7EVLXMgnR7L0x8S-CQvGh4F1DKeabj2J0eenPW3324lXV	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:27:04.33+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
hyJrwrpAO0Kgv443rR-kck-jENDyBcml9jsNBHMPa9SHFBRbrQOzT-s4PSnRBUco	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:28:36.468+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
uEykJumcxC3q8Jxlko-SNBSlFb_c9VFyPM7hlMTugXdwDeudRykBe8UWh2Wv7Aux	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:28:36.469+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
PYMTpb3d7ONcglHT3Op4tUIo2Dj68e-XE0bZVg_m3s4w1yWoMh8KMYOcWknGusxA	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:28:36.472+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
5qbak8P7RCXIFDKpZidoVGVLJ_Jr-6rIV21GPGJh9mzrXy7li-3fLMcXONTKFI_8	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:32:05.849+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
ZjH7BsT7SYyN4SxG1B1BYmCUGXc33gdeafyedWb-Q2jbygePAW-BB-icInZRg3PJ	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 09:19:34.109+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8081	\N
CQV9By-wG4463Q1O3ZG06ztBpDjNYN52Gp94lfJ9sjoeixAc7mQvhZEcFUkvODok	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:27:04.33+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
qTAWMo6qtha2dsvvBy1Jn6zCD5bj7sFGnaCByFdygaix_HKpc0jai0D6YLqJeSMO	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:27:04.351+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
7OBIaZmxg6VA-5wuiqhnnL_v5KAqfEPNqzuEPmKKlb5XOsRvQiMcGuKwX6PgO0X6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:28:36.483+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
5AhWJEj0Zjhc_DVVTBIBiG0VrPSar-04tYfE6mnrtg71BswHa_OikE-HZlCAaPqL	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:28:36.5+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
S35LDLmqpdMQkSoWAjB-nA17vunhBiKmpCzcEffY8lvFdp1sSCLX38c1ga4mHczS	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:32:05.83+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
pjZLDfPCZpebDGC1pYRsRMuSSe3L0SWUeteWuRgAjWeyJ3QVaRqBfdwFEb3WVoGh	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:32:05.844+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
V01milQ4UYwcHAKmbi7KA4UQN2Fn-fw_K_7yEhfjjKO9OGX5EJIIixL1Jweo5dc6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:32:05.851+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
GkK7ipa77UsQbymc3bV5t-4V-9U1_pu_c1GWO5GtISjaigddHw-ED4AlUy8VRZhg	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 02:32:05.868+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8080	\N
hz3ia1vepdywNOG0HdFkknE7Vcjtgn4sWrhlV83PKnKJgDyJOSFAbpcxgM3xHYtv	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:11:37.731+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/26.2 Safari/605.1.15	\N	http://localhost:8055	\N
V63q3VSnBkHb4TvWnWj8HV6Ck1QpuGK0p8WSV58btjSJKfK2HUCDTuhiJs7QzuJB	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:12:56.427+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
WZUzpNqmU8XmAKgdrGoaDlJwBPTR7wVE2qhI8uChUJ7-UWHhulgJ79Sp2_uE7tg6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:12:56.466+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
j-e9uoCymysEAXNVScFkpq3fw_xI0OvS5sjO4nQDHrsUZ1T5hY_dxdMWX5O750eK	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:12:56.484+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
2N413Qb9xRQ8e6uYtvf_VMAPHwaP9vN9PDUIFDSvEn65dZIyYkBim2-Po0N7ekLK	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:12:56.485+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
n-tgom18h9ZgOP2KWYBnd4RPN-YEv19ceN-186CpkXhAoG6jlr18hQHveimY4lNL	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:12:56.498+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
a5L3MwOmGuSdX1u2dbcIAIAMEP_83Q6IR0avqnx__AJEEG3rCWNi9n1SboNf0vcI	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:14:20.948+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
1OGaisw-uv0yY67vqlGTeC07WkdZAUNF-IA_xUzU2PSznPFOO8GJyic9K3k9PCrU	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:15:12.834+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
Tl4esfomWL2NPrwJZ-_Kbm3bejbVz_-CqqAolloET_Lqva9_p9o2akc0hzWC58Au	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:15:12.858+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
erVGhYbAyH_fSf3VLDcWy4OnCV_7SUIUtBzb_njDVpDjeWqOOV-P5pggE6tnWuPG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:15:12.861+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
cL_l6OZj1JjRPMSTX-GI5ArcGsXqFgyDYSMwQ9IKV2Z9fVZaq5bcQZzdSHbCj36X	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:15:12.862+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
gzEZlcHTLY87FA0j6ZcIBxqAKxNlHxeZJ4zawmWfUQzYS2tUp1PfBcIb5soPyDfK	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-25 11:15:12.879+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
gv8OmQJS0LaBz3msNGNa8IzBUylF6GYZ_wCq4qvkqzNYf9e8uQ3iA3YXHme1GEE8	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:06.298+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
8kqnml3Ys97xIY4nK4L_TZRCak6_q-kok8c_kp_9tpgZeSrJ7-U_2kW25eMn5P0T	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:06.309+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
U27jC_oB4vrqkRx6Tefnw4QrQuCYVcpPZCGfTOehi4s5r3sg9yo6u5RLPmKPJQJw	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:06.31+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
uCgQVc1FAnU0phYFxZ9O1u6h__jmiQnINmmnWSXgrFwv5eHH59b7Y5n-BepogSBg	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:06.316+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
22zc5P0eFMMb9X9Oz6AuGCzOIBZRz4A53BjaK5_y_xwF4ALWVt2dGC3ya9d2tpk3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:06.335+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
g85aA5FBnFs-kfQa_InJ4sZDZ1hVzixy8d-tZedDObCwd9c5-qUyoOtQm-1jtZfq	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:22:51.495+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8055	\N
eZWCW_QY0-8S5E4IMmSVqk6qPOJC2O6XlxfqcxvuQoMtVQsgpw-hcu4dB1lgqrdy	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:30:25.817+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8082	\N
99CY6_cCpS0ttHr-4I7bL0JlU2w8GGmfZdlBokfBeOrgV5YUUY5FjOoO7dS1casG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:33:24.671+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
SIRL-z8NVVosCfcRGIbNZwg3uguj6NpH8s6YMJhrIm-YtF1-CZoO-CvEIy0lRY7d	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:33:24.679+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
Z8rtb0_37VSdxV-yW-uG8eh8Z510hxW6re1JpSukwZbELVHsuYF1uAl8vQJ1UmoO	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:33:24.684+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
81V0aMw41zmKP_fhLW2l3355hFogGrg6lts0N-XmIMnNQPNA0Ys2UrmDFOLc0jKi	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:33:24.689+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
tcJ6V5dsHFahPT1V3KVcmCIiIMUP__xitPX8k5_pezarxfZ3wzsh8oAlkv14jOAG	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 10:33:24.711+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
Y9mQ-4v51Qj1yFxZ7EUwHZznIuOmxRkSehkvQ4-aoQjusN-ECIwd72DuLEozypwR	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 11:14:24.478+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
2RcXCfMo-_HibKJUp8gMapn7xzDzRUP3UTspz2Pt90broTZd9ry7ho5yLQXBSagu	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 11:14:24.49+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
o7yh75Z9iRVSRa0ajpSueAslQzgiVlDLVU0b1wDkwYO8JNq_SJICsidfqrfhi6ZY	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 11:14:24.497+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
qtsGjBGFZyzu8Y1DSMH6Uq88EKj_9VbmTkMaOfSbZdQTAIGv2943IoqlwWWB60SP	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 11:14:24.497+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
KkiBm5v1EI9lmw7cKRdvrot8JxAtE2JKqRab_wYUsXm5b97k2xAHMfmB634GqV0J	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-26 11:14:24.515+00	192.168.65.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36	\N	http://localhost:8083	\N
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios, public_favicon, default_appearance, default_theme_light, theme_light_overrides, default_theme_dark, theme_dark_overrides, report_error_url, report_bug_url, report_feature_url, public_registration, public_registration_verify_email, public_registration_role, public_registration_email_filter, visual_editor_urls, project_id, mcp_enabled, mcp_allow_deletes, mcp_prompts_collection, mcp_system_prompt_enabled, mcp_system_prompt, project_owner, project_usage, org_name, product_updates, project_status, ai_openai_api_key, ai_anthropic_api_key, ai_system_prompt) FROM stdin;
1	Directus	\N	#6644FF	\N	\N	\N	\N	25	\N	all	\N	\N	\N	\N	\N	\N	\N	en-US	\N	\N	auto	\N	\N	\N	\N	\N	\N	\N	f	t	\N	\N	\N	019bcd66-0372-722b-a91b-b3380385e2b7	f	f	\N	t	\N	admin@example.com	personal	\N	t	\N	\N	\N	\N
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
3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$rhb+2Lw9V5vrPGklq298bg$tRwB2FdM/oiQ42rKBnGbGuBKGDPwaF6bkYL2AnSqGpI	\N	\N	\N	\N	\N	\N	\N	active	677626c9-1d30-4155-9226-87162d9c9a10	\N	2026-01-19 11:14:24.517+00	/users	default	\N	\N	t	\N	\N	\N	\N	\N	auto
\.


--
-- Data for Name: directus_versions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_versions (id, key, name, collection, item, hash, date_created, date_updated, user_created, user_updated, delta) FROM stdin;
\.


--
-- Data for Name: inventory; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.inventory (id, product_name, sku, quantity, price, category, description, reorder_level, supplier, status, user_created, user_updated, date_created, date_updated, unit) FROM stdin;
4	Cotton Fabric (White)	\N	25	800.00000	Fabric	\N	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	\N	2026-01-17 19:53:57.365+00	\N	meters
5	Velvet Fabric (Black)	\N	12	2000.00000	Fabric	\N	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.379+00	2026-01-18 02:32:15.517+00	meters
6	Cotton Thread (Black)	\N	47	50.00000	Thread	Manok manok nams	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.391+00	2026-01-18 02:32:15.538+00	spools
7	Buttons (Gold)	\N	111	25.00000	Accessories	\N	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.403+00	2026-01-18 11:14:12.171+00	pieces
3	Silk Fabric (Red)	\N	5	1500.00000	Fabric	\N	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-17 19:53:57.346+00	2026-01-18 11:15:41.798+00	meters
9	manok	\N	40	500.00000	Accessories	\N	10	\N	in_stock	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:31:37.577+00	2026-01-19 10:34:25.087+00	meters
\.


--
-- Data for Name: inventory_images; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.inventory_images (id, inventory_id, directus_files_id, date_created) FROM stdin;
1	6	bf638d96-846b-47a5-b56b-5fba4d2edb43	2026-01-17 21:57:15.989+00
2	6	a5e977e2-01df-43d0-83c7-13f998bec552	2026-01-17 21:57:16.017+00
3	6	49cf37b3-efbd-4c09-85df-ac2b2b9dc16f	2026-01-17 21:57:16.04+00
4	6	bf3239c3-ee4a-4ff6-b6ce-b8788cc3f782	2026-01-17 21:57:16.064+00
5	6	c01a1aa0-993e-4a1c-8676-4ec30cb69811	2026-01-17 21:57:16.088+00
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.order_items (id, user_created, date_created, user_updated, date_updated, order_id, inventory_id, product_name, quantity, unit_price, subtotal) FROM stdin;
1	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:48:41.872+00	\N	\N	1	5	Velvet Fabric (Black)	1	2000.00	2000.00
2	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:48.207+00	\N	\N	2	3	Silk Fabric (Red)	3	1500.00	4500.00
3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:20:41.724+00	\N	\N	3	3	Silk Fabric (Red)	5	1500.00	7500.00
4	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:07.633+00	\N	\N	4	7	Buttons (Gold)	5	25.00	125.00
5	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.256+00	\N	\N	5	5	Velvet Fabric (Black)	2	2000.00	4000.00
6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.267+00	\N	\N	5	6	Cotton Thread (Black)	3	50.00	150.00
7	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.268+00	\N	\N	5	7	Buttons (Gold)	4	25.00	100.00
8	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:13:53.523+00	\N	\N	6	3	Silk Fabric (Red)	10	1500.00	15000.00
9	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:32:58.066+00	\N	\N	7	9	manok	5	500.00	2500.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.orders (id, user_created, date_created, user_updated, date_updated, customer_name, customer_email, customer_phone, shipping_address, payment_method, status, subtotal, shipping_fee, total_amount, notes, user_id) FROM stdin;
2	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:16:48.178+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:24:54.872+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	completed	4500.00	50.00	4550.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
3	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:20:41.705+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:12.135+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	processed	7500.00	50.00	7550.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
1	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 01:48:41.853+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:27:25.977+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	processed	2000.00	50.00	2050.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
5	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:31:40.228+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:32:15.582+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	processed	4250.00	50.00	4300.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
4	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 02:28:07.616+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:14:47.557+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	completed	125.00	50.00	175.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
6	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:13:53.498+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-18 11:15:55.094+00	Admin User	admin@example.com	09632532951	Sitio Sambat., Barangay Lalo	cod	completed	15000.00	50.00	15050.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
7	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:32:58.045+00	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28	2026-01-19 10:34:58.342+00	Admin User	admin@example.com	09564968599	Sitio Sambat., Barangay Lalo	cod	completed	2500.00	50.00	2550.00	\N	3eee48f9-2a9e-438c-ae27-d6eca2c3ec28
\.


--
-- Data for Name: units; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.units (id, name, abbreviation, status, date_created, date_updated) FROM stdin;
1	meters	m	active	2026-01-17 20:09:32.464+00	\N
2	pieces	pcs	active	2026-01-17 20:09:32.476+00	\N
3	spools	spl	active	2026-01-17 20:09:32.491+00	\N
4	yards	yd	active	2026-01-17 20:09:32.512+00	\N
5	rolls	rol	active	2026-01-17 20:09:32.524+00	\N
\.


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.categories_id_seq', 3, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 277, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 60, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 1, false);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 2, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 7, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 139, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, true);


--
-- Name: inventory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.inventory_id_seq', 9, true);


--
-- Name: inventory_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.inventory_images_id_seq', 5, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.order_items_id_seq', 9, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.orders_id_seq', 7, true);


--
-- Name: units_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.units_id_seq', 5, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


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
-- Name: inventory_images inventory_images_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.inventory_images
    ADD CONSTRAINT inventory_images_pkey PRIMARY KEY (id);


--
-- Name: inventory inventory_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: units units_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.units
    ADD CONSTRAINT units_pkey PRIMARY KEY (id);


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
-- Name: inventory_images inventory_images_inventory_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.inventory_images
    ADD CONSTRAINT inventory_images_inventory_id_foreign FOREIGN KEY (inventory_id) REFERENCES public.inventory(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_inventory_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_inventory_id_foreign FOREIGN KEY (inventory_id) REFERENCES public.inventory(id) ON DELETE SET NULL;


--
-- Name: order_items order_items_order_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_foreign FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE SET NULL;


--
-- Name: order_items order_items_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: order_items order_items_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- Name: orders orders_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id);


--
-- Name: orders orders_user_updated_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_updated_foreign FOREIGN KEY (user_updated) REFERENCES public.directus_users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict 7xyLzaefmaZPJbmn0ty8BsyGCDN0LeTgYAdeU7yDkvIYBJTUdvULM1hRBiQ9ubi

