# $FreeBSD$

PORTNAME=	icinga2-network-plugin
PORTVERSION=	20200316
DISTVERSIONPREFIX=	v
#DISTVERSION=	0.2.0
#PORTREVISION=	1
CATEGORIES=	net-mgmt

MAINTAINER=	hsw@bitmark.com
COMMENT=	Interface for icinga2 to use net/vnstat

LICENSE=	BSD2CLAUSE
LICENSE_FILE=	${WRKSRC}/LICENSE

ONLY_FOR_ARCHS=	amd64 armv6 armv7 i386
ONLY_FOR_ARCHS_REASON=	depends on go which is not supported in this \
			architecture

RUN_DEPENDS=	vnstat:net/vnstat

USES=		go:modules

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT
GH_PROJECT=	icinga2-network-plugin
GH_TAGNAME=	39ac89efa296
GH_TUPLE=

PLIST_FILES+=	"@dir libexec/nagios"
PLIST_FILES+=	libexec/nagios/icinga2-network-plugin

GO_BUILDFLAGS+=	-ldflags="-X main.version=${DISTVERSION}"

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/libexec/nagios
	${INSTALL_PROGRAM} ${WRKDIR}/bin/icinga2-network-plugin ${STAGEDIR}${PREFIX}/libexec/nagios

.include <bsd.port.mk>
