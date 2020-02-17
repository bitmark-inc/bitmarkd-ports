# $FreeBSD$

PORTNAME=	bitmark-p2p
PORTVERSION=	20200217
DISTVERSIONPREFIX=	v
#DISTVERSION=	0.12.4
CATEGORIES=	net-p2p

MAINTAINER=	hsw@bitmark.com
COMMENT?=	Bitmark distributed property system programs

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 armv6 armv7 i386
ONLY_FOR_ARCHS_REASON=	depends on go which is not supported in this \
			architecture

LIB_DEPENDS=	libargon2.so:security/libargon2 \
		libzmq.so:net/libzmq4

USES=		go:modules pkgconfig

CONFLICTS?=	bitmark-p2p-{daemon,cli,recorder,dumper} \
		bitmark-{daemon,cli,recorder,dumper} \
		bitmark
SLAVE_PORT?=	no

OPTIONS_DEFINE?=	CLI DAEMON DUMPER RECORDER
OPTIONS_DEFAULT?=	CLI DAEMON RECORDER
OPTIONS_SUB=		yes

DAEMON_DESC=	Main bitmarkd node server
CLI_DESC=	Command line program to access bitmarks
DUMPER_DESC=	Utility to dump bitmarkd levelDB
RECORDER_DESC=	Hashing program

.include <bsd.port.options.mk>

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_PROJECT=	bitmarkd
GH_TAGNAME=	aa634b05ce3a
GH_TUPLE=	\
		alecthomas:kingpin:v2.2.6:alecthomas_kingpin/vendor/gopkg.in/alecthomas/kingpin.v2 \
		alecthomas:template:fb15b899a751:alecthomas_template/vendor/github.com/alecthomas/template \
		alecthomas:units:c3de453c63f4:alecthomas_units/vendor/github.com/alecthomas/units \
		bitmark-inc:certgen:v0.1.1:bitmark_inc_certgen/vendor/github.com/bitmark-inc/certgen \
		bitmark-inc:exitwithstatus:v0.1.2:bitmark_inc_exitwithstatus/vendor/github.com/bitmark-inc/exitwithstatus \
		bitmark-inc:getoptions:v0.1.1:bitmark_inc_getoptions/vendor/github.com/bitmark-inc/getoptions \
		bitmark-inc:go-argon2:v0.1.4:bitmark_inc_go_argon2/vendor/github.com/bitmark-inc/go-argon2 \
		bitmark-inc:logger:v0.3.4:bitmark_inc_logger/vendor/github.com/bitmark-inc/logger \
		btcsuite:btcd:130ea5bddde3:btcsuite_btcd/vendor/github.com/btcsuite/btcd \
		btcsuite:btclog:84c8d2346e9f:btcsuite_btclog/vendor/github.com/btcsuite/btclog \
		btcsuite:btcutil:9e5f4b9a998d:btcsuite_btcutil/vendor/github.com/btcsuite/btcutil \
		btcsuite:go-socks:4720035b7bfd:btcsuite_go_socks/vendor/github.com/btcsuite/go-socks \
		census-instrumentation:opencensus-go:v0.22.1:census_instrumentation_opencensus_go/vendor/go.opencensus.io \
		cihub:seelog:f561c5e57575:cihub_seelog/vendor/github.com/cihub/seelog \
		coreos:go-semver:v0.3.0:coreos_go_semver/vendor/github.com/coreos/go-semver \
		davecgh:go-spew:v1.1.1:davecgh_go_spew/vendor/github.com/davecgh/go-spew \
		fsnotify:fsnotify:v1.4.7:fsnotify_fsnotify/vendor/github.com/fsnotify/fsnotify \
		go-yaml:yaml:v2.2.2:go_yaml_yaml/vendor/gopkg.in/yaml.v2 \
		gogo:protobuf:v1.3.0:gogo_protobuf/vendor/github.com/gogo/protobuf \
		golang:crypto:9ee001bba392:golang_crypto/vendor/golang.org/x/crypto \
		golang:net:ba9fcec4b297:golang_net/vendor/golang.org/x/net \
		golang:protobuf:v1.3.2:golang_protobuf/vendor/github.com/golang/protobuf \
		golang:snappy:v0.0.1:golang_snappy/vendor/github.com/golang/snappy \
		golang:sync:112230192c58:golang_sync/vendor/golang.org/x/sync \
		golang:sys:0a153f010e69:golang_sys/vendor/golang.org/x/sys \
		golang:text:v0.3.2:golang_text/vendor/golang.org/x/text \
		golang:time:9d24e82272b4:golang_time/vendor/golang.org/x/time \
		google:uuid:v1.1.1:google_uuid/vendor/github.com/google/uuid \
		gorilla:websocket:v1.4.1:gorilla_websocket/vendor/github.com/gorilla/websocket \
		hashicorp:golang-lru:v0.5.1:hashicorp_golang_lru/vendor/github.com/hashicorp/golang-lru \
		huin:goupnp:v1.0.0:huin_goupnp/vendor/github.com/huin/goupnp \
		ipfs:go-cid:v0.0.3:ipfs_go_cid/vendor/github.com/ipfs/go-cid \
		ipfs:go-ipfs-util:v0.0.1:ipfs_go_ipfs_util/vendor/github.com/ipfs/go-ipfs-util \
		ipfs:go-log:v0.0.1:ipfs_go_log/vendor/github.com/ipfs/go-log \
		jackpal:gateway:v1.0.5:jackpal_gateway/vendor/github.com/jackpal/gateway \
		jackpal:go-nat-pmp:v1.0.1:jackpal_go_nat_pmp/vendor/github.com/jackpal/go-nat-pmp \
		jbenet:goprocess:v0.1.3:jbenet_goprocess/vendor/github.com/jbenet/goprocess \
		jbenet:go-temp-err-catcher:aac704a3f4f2:jbenet_go_temp_err_catcher/vendor/github.com/jbenet/go-temp-err-catcher \
		koron:go-ssdp:4a0ed625a78b:koron_go_ssdp/vendor/github.com/koron/go-ssdp \
		libp2p:go-addr-util:v0.0.1:libp2p_go_addr_util/vendor/github.com/libp2p/go-addr-util \
		libp2p:go-conn-security-multistream:v0.1.0:libp2p_go_conn_security_multistream/vendor/github.com/libp2p/go-conn-security-multistream \
		libp2p:go-flow-metrics:v0.0.1:libp2p_go_flow_metrics/vendor/github.com/libp2p/go-flow-metrics \
		libp2p:go-buffer-pool:v0.0.2:libp2p_go_buffer_pool/vendor/github.com/libp2p/go-buffer-pool \
		libp2p:go-eventbus:v0.1.0:libp2p_go_eventbus/vendor/github.com/libp2p/go-eventbus \
		libp2p:go-libp2p-autonat:v0.1.0:libp2p_go_libp2p_autonat/vendor/github.com/libp2p/go-libp2p-autonat \
		libp2p:go-libp2p-core:v0.2.3:libp2p_go_libp2p_core/vendor/github.com/libp2p/go-libp2p-core \
		libp2p:go-libp2p-circuit:v0.1.3:libp2p_go_libp2p_circuit/vendor/github.com/libp2p/go-libp2p-circuit \
		libp2p:go-libp2p-discovery:v0.1.0:libp2p_go_libp2p_discovery/vendor/github.com/libp2p/go-libp2p-discovery \
		libp2p:go-libp2p-mplex:v0.2.1:libp2p_go_libp2p_mplex/vendor/github.com/libp2p/go-libp2p-mplex \
		libp2p:go-libp2p-nat:v0.0.4:libp2p_go_libp2p_nat/vendor/github.com/libp2p/go-libp2p-nat \
		libp2p:go-libp2p-peerstore:v0.1.3:libp2p_go_libp2p_peerstore/vendor/github.com/libp2p/go-libp2p-peerstore \
		libp2p:go-libp2p-pubsub:v0.1.1:libp2p_go_libp2p_pubsub/vendor/github.com/libp2p/go-libp2p-pubsub \
		libp2p:go-libp2p-secio:v0.2.0:libp2p_go_libp2p_secio/vendor/github.com/libp2p/go-libp2p-secio \
		libp2p:go-libp2p-swarm:v0.2.2:libp2p_go_libp2p_swarm/vendor/github.com/libp2p/go-libp2p-swarm \
		libp2p:go-libp2p-tls:v0.1.1:libp2p_go_libp2p_tls/vendor/github.com/libp2p/go-libp2p-tls \
		libp2p:go-libp2p-transport-upgrader:v0.1.1:libp2p_go_libp2p_transport_upgrader/vendor/github.com/libp2p/go-libp2p-transport-upgrader \
		libp2p:go-libp2p-yamux:v0.2.1:libp2p_go_libp2p_yamux/vendor/github.com/libp2p/go-libp2p-yamux \
		libp2p:go-libp2p:v0.4.0:libp2p_go_libp2p/vendor/github.com/libp2p/go-libp2p \
		libp2p:go-libp2p-loggables:v0.1.0:libp2p_go_libp2p_loggables/vendor/github.com/libp2p/go-libp2p-loggables \
		libp2p:go-maddr-filter:v0.0.5:libp2p_go_maddr_filter/vendor/github.com/libp2p/go-maddr-filter \
		libp2p:go-mplex:v0.1.0:libp2p_go_mplex/vendor/github.com/libp2p/go-mplex \
		libp2p:go-msgio:v0.0.4:libp2p_go_msgio/vendor/github.com/libp2p/go-msgio \
		libp2p:go-nat:v0.0.3:libp2p_go_nat/vendor/github.com/libp2p/go-nat \
		libp2p:go-reuseport-transport:v0.0.2:libp2p_go_reuseport_transport/vendor/github.com/libp2p/go-reuseport-transport \
		libp2p:go-reuseport:v0.0.1:libp2p_go_reuseport/vendor/github.com/libp2p/go-reuseport \
		libp2p:go-stream-muxer-multistream:v0.2.0:libp2p_go_stream_muxer_multistream/vendor/github.com/libp2p/go-stream-muxer-multistream \
		libp2p:go-tcp-transport:v0.1.1:libp2p_go_tcp_transport/vendor/github.com/libp2p/go-tcp-transport \
		libp2p:go-ws-transport:v0.1.2:libp2p_go_ws_transport/vendor/github.com/libp2p/go-ws-transport \
		libp2p:go-yamux:v1.2.3:libp2p_go_yamux/vendor/github.com/libp2p/go-yamux \
		mattn:go-colorable:v0.1.1:mattn_go_colorable/vendor/github.com/mattn/go-colorable \
		mattn:go-isatty:v0.0.5:mattn_go_isatty/vendor/github.com/mattn/go-isatty \
		miekg:dns:v1.1.16:miekg_dns/vendor/github.com/miekg/dns \
		minio:blake2b-simd:3f5f724cb5b1:minio_blake2b_simd/vendor/github.com/minio/blake2b-simd \
		minio:sha256-simd:v0.1.1:minio_sha256_simd/vendor/github.com/minio/sha256-simd \
		mitchellh:mapstructure:v1.1.2:mitchellh_mapstructure/vendor/github.com/mitchellh/mapstructure \
		mr-tron:base58:v1.1.2:mr_tron_base58/vendor/github.com/mr-tron/base58 \
		multiformats:go-base32:v0.0.3:multiformats_go_base32/vendor/github.com/multiformats/go-base32 \
		multiformats:go-multiaddr-dns:v0.1.0:multiformats_go_multiaddr_dns/vendor/github.com/multiformats/go-multiaddr-dns \
		multiformats:go-multiaddr-fmt:v0.1.0:multiformats_go_multiaddr_fmt/vendor/github.com/multiformats/go-multiaddr-fmt \
		multiformats:go-multiaddr-net:v0.1.0:multiformats_go_multiaddr_net/vendor/github.com/multiformats/go-multiaddr-net \
		multiformats:go-multiaddr:v0.1.1:multiformats_go_multiaddr/vendor/github.com/multiformats/go-multiaddr \
		multiformats:go-multibase:v0.0.1:multiformats_go_multibase/vendor/github.com/multiformats/go-multibase \
		multiformats:go-multihash:v0.0.8:multiformats_go_multihash/vendor/github.com/multiformats/go-multihash \
		multiformats:go-multistream:v0.1.0:multiformats_go_multistream/vendor/github.com/multiformats/go-multistream \
		opentracing:opentracing-go:v1.0.2:opentracing_opentracing_go/vendor/github.com/opentracing/opentracing-go \
		patrickmn:go-cache:v2.1.0:patrickmn_go_cache/vendor/github.com/patrickmn/go-cache \
		pebbe:zmq4:v1.0.0:pebbe_zmq4/vendor/github.com/pebbe/zmq4 \
		pkg:errors:v0.8.1:pkg_errors/vendor/github.com/pkg/errors \
		prometheus:common:v0.7.0:prometheus_common/vendor/github.com/prometheus/common \
		sirupsen:logrus:v1.4.2:sirupsen_logrus/vendor/github.com/sirupsen/logrus \
		spaolacci:murmur3:v1.1.0:spaolacci_murmur3/vendor/github.com/spaolacci/murmur3 \
		syndtr:goleveldb:v1.0.0:syndtr_goleveldb/vendor/github.com/syndtr/goleveldb \
		urfave:cli:v1.21.0:urfave_cli/vendor/github.com/urfave/cli \
		whyrusleeping:go-logging:0457bb6b88fc:whyrusleeping_go_logging/vendor/github.com/whyrusleeping/go-logging \
		whyrusleeping:go-notifier:097c5d47330f:whyrusleeping_go_notifier/vendor/github.com/whyrusleeping/go-notifier \
		whyrusleeping:mafmt:v1.2.8:whyrusleeping_mafmt/vendor/github.com/whyrusleeping/mafmt \
		whyrusleeping:multiaddr-filter:e903e4adabd7:whyrusleeping_multiaddr_filter/vendor/github.com/whyrusleeping/multiaddr-filter \
		whyrusleeping:timecache:cfcb2f1abfee:whyrusleeping_timecache/vendor/github.com/whyrusleeping/timecache \
		yuin:gluamapper:d836955830e7:yuin_gluamapper/vendor/github.com/yuin/gluamapper \
		yuin:gopher-lua:1cd887cd7036:yuin_gopher_lua/vendor/github.com/yuin/gopher-lua

# stripping can break go binaries
STRIP=

SLAVE_PORT?=	NO

VAR_DIR=	/var

.if ${PORT_OPTIONS:MDAEMON}
USERS+=		bitmark
GROUPS+=	bitmark
BITMARKD_RUN=	${VAR_DIR}/run/bitmarkd
BITMARKD_DATA=	${VAR_DIR}/lib/bitmarkd
SERVER_LIST+=	bitmarkd
USE_RC_SUBR+=	bitmarkd
SUB_LIST+=	BITMARKD_DATA=${BITMARKD_DATA} \
		BITMARKD_GROUP=bitmark \
		BITMARKD_RUN=${BITMARKD_RUN} \
		BITMARKD_USER=bitmark
PLIST_FILES+=	"etc/bitmarkd.conf.sub"
.endif

.if ${PORT_OPTIONS:MRECORDER}
USERS+=		bitmark-recorder
GROUPS+=	bitmark-recorder
RECORDERD_RUN=	${VAR_DIR}/run/recorderd
RECORDERD_DATA=	${VAR_DIR}/lib/recorderd
SERVER_LIST+=	recorderd
USE_RC_SUBR+=	recorderd
SUB_LIST+=	RECORDERD_DATA=${RECORDERD_DATA} \
		RECORDERD_GROUP=bitmark-recorder \
		RECORDERD_RUN=${RECORDERD_RUN} \
		RECORDERD_USER=bitmark-recorder
.endif

.if ${PORT_OPTIONS:MCLI}
COMMAND_LIST+=	bitmark-cli
.endif
.if ${PORT_OPTIONS:MDUMPER}
COMMAND_LIST+=	bitmark-dumpdb
.endif

.for command in ${SERVER_LIST}
PLIST_FILES+=	"@sample etc/${command}.conf.sample" \
		etc/newsyslog.conf.d/${command}.conf \
		etc/syslog.d/${command}.conf \
		sbin/${command}
.endfor
.for command in ${COMMAND_LIST}
PLIST_FILES+=	bin/${command}
.endfor
.if ${PORT_OPTIONS:MDAEMON}
PLIST_FILES+=	"@dir(bitmark,bitmark,) ${BITMARKD_DATA}" \
		"@dir(bitmark,bitmark,) ${BITMARKD_RUN}"
.endif
.if ${PORT_OPTIONS:MRECORDER}
PLIST_FILES+=	"@dir(bitmark-recorder,bitmark-recorder,) ${RECORDERD_DATA}" \
		"@dir(bitmark-recorder,bitmark-recorder,) ${RECORDERD_RUN}"
.endif
.if ${PORT_OPTIONS:MDAEMON} || ${PORT_OPTIONS:MRECORDER}
PLIST_FILES+=	"@dir ${VAR_DIR}/lib"
.endif

GO_BUILDFLAGS+=	-ldflags="-X main.version=${DISTVERSION}"

.for command in ${SERVER_LIST} ${COMMAND_LIST}
GO_TARGET+=	./command/${command}
.endfor

do-install:
.for command in ${SERVER_LIST}
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${command} ${STAGEDIR}${PREFIX}/sbin
	${INSTALL_DATA} ${WRKSRC}/command/${command}/${command}.conf.sample ${STAGEDIR}${PREFIX}/etc/${command}.conf.sample
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/syslog.d
	${MKDIR} ${STAGEDIR}${PREFIX}/etc/newsyslog.conf.d
	${INSTALL_DATA} ${FILESDIR}/${command}.syslog ${STAGEDIR}${PREFIX}/etc/syslog.d/${command}.conf
	${INSTALL_DATA} ${FILESDIR}/${command}.newsyslog ${STAGEDIR}${PREFIX}/etc/newsyslog.conf.d/${command}.conf
.endfor
.for command in ${COMMAND_LIST}
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${command} ${STAGEDIR}${PREFIX}/bin
.endfor
.if ${PORT_OPTIONS:MDAEMON}
	${INSTALL_DATA} ${WRKSRC}/command/bitmarkd/bitmarkd.conf.sub ${STAGEDIR}${PREFIX}/etc/bitmarkd.conf.sub
	${MKDIR} ${STAGEDIR}${BITMARKD_RUN}
	${MKDIR} ${STAGEDIR}${BITMARKD_DATA}
.endif
.if ${PORT_OPTIONS:MRECORDER}
	${MKDIR} ${STAGEDIR}${RECORDERD_RUN}
	${MKDIR} ${STAGEDIR}${RECORDERD_DATA}
.endif

.include <bsd.port.mk>
