# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	miniature-spoon
PORTVERSION=	1.2
DISTVERSIONPREFIX=	v
CATEGORIES=	net

MAINTAINER=	hsw@bitmark.com
COMMENT=	Restricted bitcoin RPC proxy

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

LIB_DEPENDS=	libucl.so:${PORTSDIR}/textproc/libucl
BUILD_DEPENDS=	go:${PORTSDIR}/lang/go

#USES=		pkgconfig
ONLY_FOR_ARCHS=	i386 amd64

USE_GITHUB=	yes

GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_PROJECT=	go-libucl:go_libucl
GH_TAGNAME=	6e53e8a:go_libucl

STRIP=		# stripping can break go binaries

USERS=		nobody
GROUPS=		nogroup
MINIATURE_SPOON_RUN=	/var/run/miniature-spoon

#PLIST_FILES=	"@sample %%ETCDIR%%/miniature-spoon.conf.sample" ## if want etc/Miniature-Spoon/miniature-spoon.conf.sample
PLIST_FILES=	"@sample etc/miniature-spoon.conf.sample"
PLIST_FILES+=	sbin/miniature-spoon

USE_RC_SUBR=	miniature-spoon
SUB_LIST+=	MINIATURE_SPOON_USER=nobody \
		MINIATURE_SPOON_GROUP=nogroup \
		MINIATURE_SPOON_RUN=${MINIATURE_SPOON_RUN}

MINIATURE-SPOON_ITEMS=	\
		doc.go \
		droppriv.go \
		handler.go \
		main.go \
		rpc.go \
		version.go

post-patch:
.for account in bitmark-inc
	@${MKDIR} ${WRKSRC}/src/github.com/${account}
.endfor

	${MKDIR} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.for src in ${MINIATURE-SPOON_ITEMS}
	@${MV} ${WRKSRC}/${src} ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME}
.endfor

do-build:
	@cd ${WRKSRC}/src/github.com/${GH_ACCOUNT}/${PORTNAME} && ${SETENV} GOPATH=${WRKSRC} go install .

do-install:
	${INSTALL_PROGRAM} ${WRKSRC}/bin/miniature-spoon ${STAGEDIR}${PREFIX}/sbin
#	${INSTALL_MAN} ${WRKSRC}/man/miniature-spoon.1 ${STAGEDIR}${MAN1PREFIX}/man/man1
	${INSTALL_DATA} ${WRKSRC}/miniature-spoon.conf.sample ${STAGEDIR}${PREFIX}/etc/miniature-spoon.conf.sample

.include <bsd.port.mk>
