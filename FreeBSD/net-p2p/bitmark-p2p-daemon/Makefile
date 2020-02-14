# $FreeBSD$

MASTERDIR=	${.CURDIR}/../bitmark-p2p
PKGNAMESUFFIX=	-daemon

COMMENT=	Bitmark distributed property system daemon

CONFLICTS?=	bitmark bitmark-p2p
SLAVE_PORT=	yes

OPTIONS_DEFINE=		DAEMON
OPTIONS_DEFAULT=	DAEMON

.include "${MASTERDIR}/Makefile"
