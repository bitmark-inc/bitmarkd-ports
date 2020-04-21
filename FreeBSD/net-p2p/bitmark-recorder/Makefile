# $FreeBSD: head/net-p2p/bitmark-recorder/Makefile 523293 2020-01-17 10:46:13Z araujo $

MASTERDIR=	${.CURDIR}/../bitmark
PKGNAMESUFFIX=	-recorder

COMMENT=	Bitmark distributed property system recorder

CONFLICTS?=	bitmark
SLAVE_PORT=	yes

OPTIONS_DEFINE=		RECORDER
OPTIONS_DEFAULT=	RECORDER

.include "${MASTERDIR}/Makefile"
