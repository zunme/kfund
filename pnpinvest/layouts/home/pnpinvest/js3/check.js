function check_all(f)
{
    var check = document.getElementsByName("check[]");

    for (i=0; i<check.length; i++)
        check[i].checked = f.chkall.checked;
}

function btn_check(f, act)
{
    if (act == "update") // 선택수정
    {
        f.action = "./class/?update=member_list";
        str = "수정";
    }
    else if (act == "delete") // 선택삭제
    {
        f.action = "./class/?update=member_list";
        str = "삭제";
    }
    else
        return;

    var check = document.getElementsByName("check[]");
    var bcheck = false;

    for (i=0; i<check.length; i++)
    {
        if (check[i].checked)
            bcheck = true;
    }

    if (!bcheck)
    {
        alert(str + "할 자료를 하나 이상 선택하세요.");
        return;
    }

    if (act == "delete")
    {
        if (!confirm("선택한 자료를 정말 삭제 하시겠습니까?"))
            return;
    }

    f.submit();
}

function is_checked(elements_name)
{
    var checked = false;
    var check = document.getElementsByName(elements_name);
    for (var i=0; i<check.length; i++) {
        if (check[i].checked) {
            checked = true;
        }
    }
    return checked;
}

function delete_confirm()
{
    if(confirm("한번 삭제한 자료는 복구할 방법이 없습니다.\n\n정말 삭제하시겠습니까?"))
        return true;
    else
        return false;
}

function delete_confirm2(msg)
{
    if(confirm(msg))
        return true;
    else
        return false;
}