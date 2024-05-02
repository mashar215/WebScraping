# コンパイラ C++なのでG++
CXX = g++

# コンパイルオプション　警告を出す
CXXFLAGS = -Wall

# プログラムによって生成されるファイルの名前
TARGET = WebScraper

# コンパイル対象のソースコード
SRCS = scraper.cpp

# オブジェクトファイル名
OBJS = $(SRCS:.cpp=.o)

# インクルードファイルのあるディレクトリパス
INCDIR = -I /usr/include/x86_64-linux-gnu/ -I /usr/include/libxml2/

# ライブラリファイルのあるディレクトリパス
LIBDIR = -L/usr/lib/x86_64-linux-gnu/

# 追加するライブラリファイルの名前
LIBS = -l xml2 -l curl

# オブジェクトファイルの作成
$(OBJS): $(SRCS)
	$(CXX) $(CXXFLAGS) $(INCDIR) -c $(SRCS)

# g++ -Wall -I /usr/include/x86_64-linux-gnu/ -I /usr/include/libxml2/ -c scraper.cpp 

# ターゲットの生成
$(TARGET): $(OBJS)
	$(CXX) -o $@ $(^F) $(LIBDIR) $(LIBS)

# g++ -o WebScraper scraper.o -L/usr/lib/x86_64-linux-gnu/ -l xml2 -l curl

# 実は1,2段階踏めばコンパイルをすることは可能であるが、makeのルールのオプションを自由に付け加えることができる。
all: clean $(OBJS) $(TARGET)

clean:
	rm -f $(OBJS) $(TARGET) *.d
