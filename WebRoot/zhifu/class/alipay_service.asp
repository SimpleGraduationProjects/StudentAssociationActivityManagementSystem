<%
	'������alipay_service
	'���ܣ�֧�����ⲿ����ӿڿ���
	'��ϸ����ҳ��������������Ĵ����ļ�������Ҫ�޸�
	'�汾��3.1
	'�޸����ڣ�2010-10-29
	'˵����
	'���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
	'�ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο�
%>

<!--#include file="alipay_function.asp"-->

<%

dim gateway			'���ص�ַ
dim mysign			'ǩ�����
dim sPara		'��Ҫǩ�����Ѿ����˺�Ĳ�������

'********************************************************************************

'���캯��
'�������ļ�������ļ��г�ʼ������
'inputPara ��Ҫǩ���Ĳ�������
function alipay_service(inputPara)
	gateway = "https://www.alipay.com/cooperate/gateway.do?"
	sPara = para_filter(inputPara)
	sort_para = arg_sort(sPara)		'�õ�����ĸa��z������ǩ����������
	'���ǩ�����
	mysign = build_mysign(sort_para,key,sign_type,input_charset)
end function

'********************************************************************************

'������ύHTML
'��� ���ύHTML�ı�
function build_form()
	'GET��ʽ����
	sHtml = "<form id='alipaysubmit' name='alipaysubmit' action='"& gateway &"_input_charset="&input_charset&"' method='get'>"
	'POST��ʽ���ݣ�GET��POST����ѡһ��
	'sHtml = "<form id='alipaysubmit' name='alipaysubmit' action='"& gateway &"_input_charset="&input_charset&"' method='post'>"

	nCount = ubound(sPara)
	for i = 0 to nCount
		'��sArray���������Ԫ�ظ�ʽ��������=ֵ���ָ��
		pos = Instr(sPara(i),"=")			'���=�ַ���λ��
		nLen = Len(sPara(i))				'����ַ�������
		itemName = left(sPara(i),pos-1)		'��ñ�����
		itemValue = right(sPara(i),nLen-pos)'��ñ�����ֵ
		
		sHtml = sHtml & "<input type='hidden' name='"& itemName &"' value='"& itemValue &"'/>"
	next

	sHtml = sHtml & "<input type='hidden' name='sign' value='"& mysign &"'/>"
	sHtml = sHtml & "<input type='hidden' name='sign_type' value='"& sign_type &"'/>"

	'submit��ť�ؼ��벻Ҫ����name����
	sHtml = sHtml & "<input type=""submit"" value=""֧����ȷ�ϸ���""></form>"
	
	sHtml = sHtml & "<script>document.forms['alipaysubmit'].submit();</script>"
	
	build_form = sHtml
end function

%>