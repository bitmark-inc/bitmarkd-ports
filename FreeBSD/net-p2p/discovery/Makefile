# Created by: Linzy Hu <linzy@bitmark.com>
# $FreeBSD$

PORTNAME=	discovery
PORTVERSION=	0.3
PORTREVISION=	8
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	linzy@bitmark.com
COMMENT=	N/A

LIB_DEPENDS=	libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=		yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE= cihub:seelog:7bfb793:seelog \
		bitmark-inc:logger:v2.0:logger \
		hashicorp:hcl:392dba7:hcl \
		pebbe:zmq4:86a3013:zmq4

USERS=	discovery
GROUPS=	discovery
DISCOVERY_DATA=	/var/lib/discovery
DISCOVERY_RUN=	/var/run/discovery

USE_RC_SUBR=discovery
SUB_LIST+=	DISCOVERY_USER=discovery \
		DISCOVERY_GROUP=discovery \
		DISCOVERY_DATA=${DISCOVERY_DATA} \
		DISCOVERY_RUN=${DISCOVERY_RUN}

PLIST_SUB+=	DISCOVERY_USER=discovery \
		DISCOVERY_GROUP=discovery \
		DISCOVERY_DATA=${DISCOVERY_DATA} \
		DISCOVERY_RUN=${DISCOVERY_RUN}
PLIST_FILES+=	bin/${PORTNAME}
PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"
PLIST_FILES+=	"@dir(%%DISCOVERY_USER%%,%%DISCOVERY_GROUP%%,) %%DISCOVERY_DATA%%"
PLIST_FILES+=	"@dir(%%DISCOVERY_USER%%,%%DISCOVERY_GROUP%%,) %%DISCOVERY_RUN%%"
PLIST_FILES+=	"@dir /var/lib"

post-patch:
.for account in bitmark-inc cihub hashicorp pebbe
	@${MKDIR} ${WRKDIR}/src/github.com/${account}
.endfor
	@${MV} ${WRKSRC_logger} ${WRKDIR}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_seelog} ${WRKDIR}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_hcl} ${WRKDIR}/src/github.com/hashicorp/hcl
	@${MV} ${WRKSRC_zmq4} ${WRKDIR}/src/github.com/pebbe/zmq4
	@${MV} ${WRKSRC} ${WRKDIR}/src/github.com/bitmark-inc/discovery

do-build:
	@cd ${WRKDIR}/src/github.com/bitmark-inc/discovery && ${SETENV} GOPATH=${WRKDIR} go "install" .

do-install:
	${INSTALL_PROGRAM} ${WRKDIR}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKDIR}/src/github.com/bitmark-inc/discovery/discovery.conf.sample ${STAGEDIR}${PREFIX}/etc/discovery.conf.sample
	${MKDIR} ${STAGEDIR}${DISCOVERY_DATA}
	${MKDIR} ${STAGEDIR}${DISCOVERY_RUN}

.include <bsd.port.mk>