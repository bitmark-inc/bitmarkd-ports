# Created by: Linzy Hu <linzy@bitmark.com>
# $FreeBSD$

PORTNAME=	discovery
PORTVERSION=	0.1
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p

MAINTAINER=	linzy@bitmark.com
COMMENT=	monitors various crypto-currencies for Bitmark transfer payments

LICENSE=	BITMARK
LICENSE_NAME=	Bitmark License
LICENSE_FILE=	${WRKDIR}/LICENSE
LICENSE_PERMS=	auto-accept

LIB_DEPENDS=	libzmq.so:net/libzmq4
BUILD_DEPENDS=	go:lang/go

USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_TUPLE=	cihub:seelog:7bfb793:seelog \
		bitmark-inc:logger:v2.0:logger \
		hashicorp:hcl:392dba7:hcl \
		pebbe:zmq4:86a3013:zmq4

STRIP=		# stripping can break go binaries

USERS=		discovery
GROUPS=		discovery
DISCOVERY_DATA=	/var/lib/discovery

PLIST_FILES+=	"@sample etc/${PORTNAME}.conf.sample"
PLIST_FILES+=	sbin/${PORTNAME}
PLIST_FILES+=	"@dir(%%UPDATERD_USER%%,%%UPDATERD_GROUP%%,) %%DISCOVERY_DATA%%"
PLIST_FILES+=	"@dir /var/lib"

USE_RC_SUBR=	${PORTNAME}
SUB_LIST+=	DISCOVERY_USER=discovery \
		DISCOVERY_GROUP=discovery \
		DISCOVERY_DATA=${DISCOVERY_DATA}
PLIST_SUB+=	DISCOVERY_USER=discovery \
		DISCOVERY_GROUP=discovery \
		DISCOVERY_DATA=${DISCOVERY_DATA}

# preserve the licence file before it is moved
post-extract:
	@${CP} -p ${WRKSRC_go_programs}/LICENSE ${WRKDIR}/LICENSE

post-patch:
.for account in bitmark-inc cihub pebbe
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	@${MKDIR} ${WRKSRC}/src/golang.org/x

	@${MV} ${WRKSRC_seelog} ${WRKSRC}/src/github.com/cihub/seelog
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/bitmark-inc/logger
	@${MV} ${WRKSRC_logger} ${WRKSRC}/src/github.com/hashicorp/hcl"
	@${MV} ${WRKSRC_zmq4} ${WRKSRC}/src/github.com/pebbe/zmq4

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go "install" .

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/${PORTNAME} ${STAGEDIR}${PREFIX}/sbin

	${INSTALL_DATA} ${WRKSRC}/src/github.com/bitmark-inc/${PORTNAME}/${PORTNAME}.conf.sample ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample

	${MKDIR} ${STAGEDIR}${DISCOVERY_DATA}

.include <bsd.port.mk>
