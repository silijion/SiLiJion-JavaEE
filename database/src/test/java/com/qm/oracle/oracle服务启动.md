### oracle服务启动
    1.默认启动的服务
        1.Oracle ORCL VSS Writer Service
            Oracle卷映射拷贝写入服务，VSS(Volume Shadow Copy Service)能够让存储基础设备(比如磁盘，阵列等)创建高保真的时间点映像，
            即映射拷贝(shadow copy)。它可以在多卷或者单个卷上创建映射拷贝，同时不会影响到系统的系统能。(非必须启动)
        2.OracleDBConsoleorcl
            Oracle数据库控制台服务，orcl是Oracle的实例标识，默认的实例为orcl。
            在运行Enterprise Manager(企业管理器OEM)的时候，需要启动这个服务。(非必须启动)
        3.OracleJobSchedulerORCL
            Oracle作业调度(定时器)服务，ORCL是Oracle实例标识。(非必须启动)
        4.OracleMTSRecoveryService
            服务端控制。该服务允许数据库充当一个微软事务服务器MTS、COM/COM+对象和分布式环境下的事务的资源管理器。(非必须启动)
        5.OracleOraDb11g_home1ClrAgent
            Oracle数据库.NET扩展服务的一部分。 (非必须启动)
        6.OracleOraDb11g_home1TNSListener
            监听器服务，服务只有在数据库需要远程访问的时候才需要。(非必须启动，下面会有详细详解)。
        7.OracleRemExecService
        
        8.OracleServiceORCL
            数据库服务(数据库实例)，是Oracle核心服务该服务，是数据库启动的基础， 只有该服务启动，Oracle数据库才能正常启动。(必须启动)