<%
 '���ܣ�֧�����ӿڹ��ú���
 '��ϸ����ҳ��������֪ͨ���������ļ������õĹ��ú������Ĵ����ļ�������Ҫ�޸�
 '�汾��3.1
 '�޸����ڣ�2010-10-29
 '˵����
 '���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
 '�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
%>

<!--#include file="alipay_md5.asp"-->

<%


'*************************************************************************************************

'����ǩ�����
'sArray Ҫǩ��������
'key ��ȫУ����
'sign_type ǩ������
'��� ǩ������ַ���
function build_mysign(sArray, key, sign_type,input_charset)
	prestr = create_linkstring(sArray)		'����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
	'ȥ������һ��&�ַ�
	nLen = Len(prestr)
	prestr = left(prestr,nLen-1)
	
    prestr = prestr & key					'��ƴ�Ӻ���ַ������밲ȫУ����ֱ����������
    mysign = sign(prestr,sign_type,input_charset)	'�����յ��ַ���ǩ�������ǩ�����

    build_mysign = mysign
end function

'*************************************************************************************************

'����������Ԫ�أ����ա�����=����ֵ����ģʽ�á�&���ַ�ƴ�ӳ��ַ���
'sArray ��Ҫƴ�ӵ�����
'��� ƴ������Ժ���ַ���
function create_linkstring(sArray)
	nCount = ubound(sArray)
	dim prestr
	for i = 0 to nCount
		prestr = prestr & sArray(i) & "&"
	next
	
	create_linkstring = prestr
end function

'*************************************************************************************************

'��ȥ�����еĿ�ֵ��ǩ������
'sArray ǩ��������
'��� ȥ����ֵ��ǩ�����������ǩ��������
function para_filter(sArray)
	dim para()
	nCount = ubound(sArray)
	dim j
	j = 0
	for i = 0 to nCount
		'��sArray���������Ԫ�ظ�ʽ��������=ֵ���ָ��
		pos = Instr(sArray(i),"=")			'���=�ַ���λ��
		nLen = Len(sArray(i))				'����ַ�������
		itemName = left(sArray(i),pos-1)	'��ñ�����
		itemValue = right(sArray(i),nLen-pos)'��ñ�����ֵ
		
		if itemName <> "sign" and itemName <> "sign_type" and itemValue <> "" then
			Redim Preserve para(j)
			para(j) = sArray(i)
			j = j + 1
		end if
	next
	para_filter = para
end function

'*************************************************************************************************

'����������
'sArray ����ǰ������
'��� ����������
function arg_sort(sArray)
	nCount = ubound(sArray)
	For i = nCount TO 0 Step -1
		minmax = sArray( 0 )
    	minmaxSlot = 0
    	For j = 1 To i
            mark = (sArray( j ) > minmax)
        	If mark Then 
            	minmax = sArray( j )
            	minmaxSlot = j
        	End If
    	Next
		If minmaxSlot <> i Then 
			temp = sArray( minmaxSlot )
			sArray( minmaxSlot ) = sArray( i )
			sArray( i ) = temp
		End If
	Next
	arg_sort = sArray
end function

'*************************************************************************************************

'ǩ���ַ���
'prestr ��Ҫǩ�����ַ���
'sign_type ǩ������
'��� ǩ�����
function sign(prestr,sign_type,input_charset)
	dim sResult
	if sign_type = "MD5" then
		sResult = md5(prestr,input_charset)
	else 
		sResult = ""
	end if
	sign = sResult
end function

'*************************************************************************************************

'���ڷ����㣬���ýӿ�query_timestamp����ȡʱ����Ĵ�����
'ע�⣺Զ�̽���XML������IIS�����������й�
'partner ���������ID
'��� ʱ����ַ���
function query_timestamp(partner)
    url = "https://mapi.alipay.com/gateway.do?service=query_timestamp&partner="&partner
	dim encrypt_key
	
	Dim http,xml
	Set http=Server.CreateObject("Microsoft.XMLHTTP")
	http.Open "GET",url,False
	http.send
	Set xml=Server.CreateObject("Microsoft.XMLDOM")
	xml.Async=true
	xml.ValidateOnParse=False
	xml.Load(http.ResponseXML)
	
	set UserData=xml.getElementsByTagName("encrypt_key")  ' �ڵ������
	if isnull(xml.getElementsByTagName("encrypt_key") ) then
		encrypt_key = ""
	else
		encrypt_key = UserData.item(0).childnodes(0).text
	end if
	
	query_timestamp = encrypt_key
end function

'*************************************************************************************************

'д��־��������ԣ�����վ����Ҳ���Ըĳɴ������ݿ⣩
'sWord Ҫд����־����ı�����
function log_result(sWord)
	randomize
	set fs= createobject("scripting.filesystemobject")
	set ts=fs.createtextfile(server.MapPath("log/"&GetDateTime()&INT((1000+1)*RND)&".txt"),true)
	ts.writeline(sWord)
	ts.close
	set ts=Nothing
	set fs=Nothing
end function

'*************************************************************************************************

'ת��ʱ�䣬
'��ʽ����[4λ]-��[2λ]-��[2λ] Сʱ[2λ 24Сʱ��]:��[2λ]:��[2λ]���磺2007-10-01 13:13:13
function GetDateTime_Format()
	sTime=now()
	sResult	= year(sTime)&"-"&right("0" & month(sTime),2)&"-"&right("0" & day(sTime),2)&" "&right("0" & hour(sTime),2)&":"&right("0" & minute(sTime),2)&":"&right("0" & second(sTime),2)
	GetDateTime_Format = sResult
end function

'*************************************************************************************************

'ת��ʱ�䣬
'��ʽ����[4λ]��[2λ]��[2λ]Сʱ[2λ 24Сʱ��]��[2λ]��[2λ]���磺20071001131313
function GetDateTime()
	sTime=now()
	sResult	= year(sTime)&right("0" & month(sTime),2)&right("0" & day(sTime),2)&right("0" & hour(sTime),2)&right("0" & minute(sTime),2)&right("0" & second(sTime),2)
	GetDateTime = sResult
end function

'*************************************************************************************************

'���������ַ�
'Str Ҫ�����˵��ַ���
'��� �ѱ����˵������ַ���
Function DelStr(Str)
	If IsNull(Str) Or IsEmpty(Str) Then
		Str	= ""
	End If
	DelStr	= Replace(Str,";","")
	DelStr	= Replace(DelStr,"'","")
	DelStr	= Replace(DelStr,"&","")
	DelStr	= Replace(DelStr," ","")
	DelStr	= Replace(DelStr,"��","")
	DelStr	= Replace(DelStr,"%20","")
	DelStr	= Replace(DelStr,"--","")
	DelStr	= Replace(DelStr,"==","")
	DelStr	= Replace(DelStr,"<","")
	DelStr	= Replace(DelStr,">","")
	DelStr	= Replace(DelStr,"%","")
End Function

'*************************************************************************************************
%>