CREATE TABLE `bmr_reple` (
  `Num` int(5) NOT NULL AUTO_INCREMENT,
  `id` varchar(10) DEFAULT NULL,
  `reple` varchar(300) DEFAULT NULL,
  `time` varchar(50) DEFAULT NULL,
  `ref` int(5) DEFAULT NULL,
  PRIMARY KEY (`Num`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=euckr;

CREATE TABLE `bmr` (
  `bmkNum` int(5) NOT NULL AUTO_INCREMENT COMMENT '��ȣ',
  `text` varchar(300) DEFAULT NULL COMMENT '����',
  `writer` varchar(10) DEFAULT NULL COMMENT '�ۼ���',
  `from` varchar(10) DEFAULT NULL COMMENT 'fromID',
  `profile` varchar(100) DEFAULT NULL COMMENT '������',
  `time` varchar(50) DEFAULT NULL COMMENT '�ð�',
  PRIMARY KEY (`bmkNum`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=euckr;

