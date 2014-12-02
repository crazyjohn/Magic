Magic
=========

a game client engine

YO YO YO! what's up biatch: if you want to make mobile game use lua easily, you got the right place, follow me, learn to use the Magic engine.


version.cn:

##结构介绍##

* client目录中是我封装的引擎的主体。

* framework中是quicks中的框架库，这里我只用了部分功能，以后会慢慢删掉无用的东西，以及把引擎主体框架重构到这里。

* resource目录下是游戏中用到的所有资源。

* test里放游戏主体无关的东西。比如管理日志，计划，以及测试代码等。


##client目录介绍##

1. enum是所有的枚举类型。这里的类型会跟server端保持一致，所以以后会用server端的工具生成。

2. event目录是引擎的事件总线目录。这里有事件总线和事件类型定义等。

3. log目录是引擎的日志系统。

4. managers目录是引擎中的静态工厂管理。包括模块管理器，视图层管理器等等。

5. mvc目录是引擎中设计的mvc框架。实现了各层之间的分离，简单易学易上手。

6. net目录中是引擎的网络部分封装。

7. util目录中是工具类。


