# rime-liur-lua
>基於RIME輸入法設計的無蝦米方案

## 功能說明：

### 中英混輸
透過空白鍵上中文字及中文符號，ENTER鍵上英文字及英文符號
><img div="中英混輸.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E4%B8%AD%E8%8B%B1%E6%B7%B7%E8%BC%B8.gif" width="600">

### 取消碼長限制
直接輸入 www.google.com.tw 按ENTER鍵，可直接上字無需切換輸入法
><img div="取消碼長限制.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E5%8F%96%E6%B6%88%E7%A2%BC%E9%95%B7%E9%99%90%E5%88%B6.gif" width="600">

### SHIFT鍵切換中英輸入
SHIFT鍵可切換中英輸入，並且將組字區內容直接上字
><img div="中英切換.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E4%B8%AD%E8%8B%B1%E5%88%87%E6%8F%9B.gif" width="600">

### 即時簡繁轉換
可利用Ctrl+.(句點)進行即時簡繁體切換
><img div="簡繁體即時轉換.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E7%B0%A1%E7%B9%81%E9%AB%94%E5%8D%B3%E6%99%82%E8%BD%89%E6%8F%9B.gif" width="600">

### 注音模式
以「';」鍵引導可進行注音輸入
### 拼音模式
以「`」鍵(上排數字鍵1左邊)引導可進行拼音輸入
><img div="注音拼音模式.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E6%B3%A8%E9%9F%B3%E6%8B%BC%E9%9F%B3%E6%A8%A1%E5%BC%8F.gif" width="600">

### 造詞模式
以「;」鍵引導進入造詞模式(透過 「\`」 來分詞，非必須，可視情形輸入)，空白鍵上字後即完成造詞。
><img div="造詞01.gif" src="https://raw.githubusercontent.com/ianzhuo/ImageCollection/master/%E9%80%A0%E8%A9%9E01.gif" width="600">

>新詞於第一次被使用後，即會列在候選字中。

>若該詞不再使用，透過上下鍵選定該詞，按下Shift+Del即可刪除。

>所造詞固定為四碼，並以每字的首碼定詞。
例：「中華民國」，可以輸入「;ci\`aj\`oxx\`oka」造詞，未來就可以利用每個字的首碼「caoo」來輸出「中華民國」

>超過四字的詞如「台南市政府」，就輸「;uo\`n\`ni\`ezp\`lpa」來造詞，並輸入一、二、三、最末字的首碼「unnl」來輸出「台南市政府」

>未滿四字詞的話，輸出時要補滿4碼(不足碼用最後一字的首碼來填)，如「捷運站」，就輸「;cz\`ncw\`lzo」來造詞，並輸入一、二、三、三的首碼「cnll」來輸出「捷運站」      