# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-pay
PORTVERSION=	3.0
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p java

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property payment client

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	mvn:devel/maven-wrapper
RUN_DEPENDS=	${LOCALBASE}/bin/getopt:misc/getopt

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT

USE_JAVA=	yes
JAVA_VERSION=	1.8+

PLIST_FILES+=	bin/bitmark-pay \
		${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar

do-install:
	@${MKDIR} ${STAGEDIR}${JAVAJARDIR}
	${REINPLACE_CMD} 's|%%BITMARK_PAY_JAR%%|${}${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar|g' ${WRKSRC}/bin/bitmark-pay
	${INSTALL_SCRIPT} ${WRKSRC}/bin/bitmark-pay ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/target/bitmarkPayService-3.x-SNAPSHOT-jar-with-dependencies.jar ${STAGEDIR}${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar

.include <bsd.port.mk>
