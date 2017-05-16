# Created by: Christopher Hall <hsw@bitmark.com>
# $FreeBSD$

PORTNAME=	bitmark-pay
PORTVERSION=	3.3
DISTVERSIONPREFIX=	v
CATEGORIES=	net-p2p java
MASTER_SITES=	http://repo.bitmark.com:8080/files/:maven
DISTFILES=	FreeBSD-${PORTNAME}-${PORTVERSION}-maven-repository.tar.gz:maven
DIST_SUBDIR=	bitmark

MAINTAINER=	hsw@bitmark.com
COMMENT=	Bitmark distributed property payment client

LICENSE=	ISCL
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${LOCALBASE}/share/java/maven33/bin/mvn:devel/maven33
RUN_DEPENDS=	${LOCALBASE}/bin/getopt:misc/getopt

USE_GITHUB=	yes
GH_ACCOUNT=	bitmark-inc:DEFAULT

USE_JAVA=	yes
JAVA_VERSION=	1.8+
MAKE_ENV+=	PATH="${LOCALBASE}/share/java/maven33/bin/:${PATH}"

PLIST_FILES+=	bin/bitmark-pay \
		${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar

post-patch:
	@cd ${WRKSRC} && ${MKDIR} local-maven-repository && ${LN} -s ../../m2 local-maven-repository

do-install:
	@${MKDIR} ${STAGEDIR}${JAVAJARDIR}
	${REINPLACE_CMD} 's|%%BITMARK_PAY_JAR%%|${}${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar|g' ${WRKSRC}/bin/bitmark-pay
	${INSTALL_SCRIPT} ${WRKSRC}/bin/bitmark-pay ${STAGEDIR}${PREFIX}/bin
	${INSTALL_DATA} ${WRKSRC}/target/bitmarkPayService-${PORTVERSION}-jar-with-dependencies.jar ${STAGEDIR}${JAVAJARDIR}/bitmarkPayService-${PORTVERSION}.jar

.include <bsd.port.mk>
