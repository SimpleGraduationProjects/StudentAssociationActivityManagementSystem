<%
 '������alipay_notify
 '���ܣ���������з�����֪ͨ��
 '��ϸ����ҳ����֪ͨ���غ��Ĵ����ļ�������Ҫ�޸�
 '�汾��3.1
 '�޸����ڣ�2010-10-29
 '˵����
 '���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
 '�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
 
'''''''''''''''''''''''ע��''''''''''''''''''''''''
'����֪ͨ����ʱ���ɲ鿴���дlog��־��д��TXT������ݣ������֪ͨ�����Ƿ�����
'''''''''''''''''''''''''''''''''''''''''''''''''''
%>

<!--#include file="alipay_function.asp"-->

<%
dim gateway			'���ص�ַ
dim mysign			'ǩ�����
gateway = "http://notify.alipay.com/trade/notify_query.do?"

'********************************************************************************

'��notify_url����֤
'��� ��֤�����true/false
function notify_verify()
	responseTxt = get_http()			'�ж���Ϣ�ǲ���֧��������
	
	sGetArray = GetRequestPost()		'��ȡ֧����POST����֪ͨ��Ϣ�����ԡ�������=����ֵ������ʽ�������

	if IsArray(sGetArray) then			'��֤�Ƿ������鴫��
		'����ǩ�����
		sArray = para_filter(sGetArray)	'������POST��������������ȥ�ո�
		sort_para = arg_sort(sArray)	'������POST������������������
		mysign  = build_mysign(sort_para,key,sign_type,input_charset)	'����ǩ�����
		
		'д��־��¼����Ҫ���ԣ���ȡ����������ע�ͣ�
		sWord = "responseTxt="& responseTxt &"\n return_url_log:sign="&request.Form("sign")&"&mysign="&mysign&"&"&create_linkstring(sort_para)
		log_result(sWord)
	
		'�ж�veryfy_responsetTxtresult�Ƿ�Ϊture�����ɵ�ǩ�����mysign���õ�ǩ�����sign�Ƿ�һ��
		'responsetTxt�Ľ������true����������������⡢���������ID��notify_idһ����ʧЧ�й�
		'mysign��sign���ȣ��밲ȫУ���롢����ʱ�Ĳ�����ʽ���磺���Զ�������ȣ��������ʽ�й�
		if mysign = request.Form("sign") and responseTxt = "true" then
			notify_verify = true
		else
			notify_verify = false
		end if
	else
		notify_verify = false
	end if
end function

'********************************************************************************

'��return_url����֤
'��� ��֤�����true/false
function return_verify()
	responseTxt = get_http()			'�ж���Ϣ�ǲ���֧��������

	sGetArray = GetRequestGet()			'��ȡ֧����GET����֪ͨ��Ϣ�����ԡ�������=����ֵ������ʽ�������

	if IsArray(sGetArray) then			'��֤�Ƿ������鴫��
		'����ǩ�����
		sArray = para_filter(sGetArray)	'������GET��������������ȥ�ո�
		sort_para = arg_sort(sArray)	'������GET������������������
		mysign  = build_mysign(sort_para,key,sign_type,input_charset)	'����ǩ�����
		
		'д��־��¼����Ҫ���ԣ���ȡ����������ע�ͣ�
		'sWord = "responseTxt="& responseTxt &"\n return_url_log:sign="&request.QueryString("sign")&"&mysign="&mysign&"&"&create_linkstring(sort_para)
		'log_result(sWord)
	
		'�ж�responsetTxt�Ƿ�Ϊture�����ɵ�ǩ�����mysign���õ�ǩ�����sign�Ƿ�һ��
		'responsetTxt�Ľ������true����������������⡢���������ID��notify_idһ����ʧЧ�й�
		'mysign��sign���ȣ��밲ȫУ���롢����ʱ�Ĳ�����ʽ���磺���Զ�������ȣ��������ʽ�й�
		if mysign = request.QueryString("sign") and responseTxt = "true" then
			return_verify = true
		else
			return_verify = false
		end if
	else
		return_verify = false
	end if
end function

'********************************************************************************

'��ȡ֧����GET����֪ͨ��Ϣ�����ԡ�������=����ֵ������ʽ�������
'��� request��������Ϣ��ɵ�����
function GetRequestGet()
	dim sArray()
	i = 0
	For Each varItem in Request.QueryString
		Redim Preserve sArray(i)
		sArray(i) = varItem&"="&Request(varItem) 
		i = i + 1
	Next 
	
	if i = 0 then	'��֤�Ƿ������鴫��
		GetRequestGet = ""
	else
		GetRequestGet = sArray
	end if
	
end function

'********************************************************************************

'��ȡ֧����POST����֪ͨ��Ϣ�����ԡ�������=����ֵ������ʽ�������
'��� request��������Ϣ��ɵ�����
function GetRequestPost()
	dim sArray()
	i = 0
	For Each varItem in Request.Form
		Redim Preserve sArray(i)
		sArray(i) = varItem&"="&Request(varItem) 
		i = i + 1
	Next 
	
	if i = 0 then	'��֤�Ƿ������鴫��
		GetRequestPost = ""
	else
		GetRequestPost = sArray
	end if
end function

'********************************************************************************

'��ȡԶ�̷�����ATN���
'��� ������ATN����ַ���
function get_http()
	gateway = gateway &"partner=" & partner & "&notify_id=" & request("notify_id")
	Set Retrieval = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
    Retrieval.setOption 2, 13056 
    Retrieval.open "GET", gateway, False, "", "" 
    Retrieval.send()
    ResponseTxt = Retrieval.ResponseText
	Set Retrieval = Nothing
	get_http = ResponseTxt
end function

'********************************************************************************

%>