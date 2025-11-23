/* global File */

let image_template = document.getElementById('image-template');
let image_templateBirthday = document.getElementById('image-templateBirthday');
let image_templateEducation = document.getElementById('image-templateEducation');
let image_templateAgreement = document.getElementById('image-templateAgreement');
let image_templateOthers = document.getElementById('image-templateOthers');
let icons_url = {
    'xlsx': 'https://img.icons8.com/color/48/000000/ms-excel.png',
    'pdf': 'https://img.icons8.com/color/50/000000/pdf.png',
    'docx': 'https://img.icons8.com/color/48/000000/word.png',
};

function get_extenstion(file) {
    return file.name.split(".")[1];
}

let file_promise = file => new Promise((resolve, reject) => {
        reader = new FileReader();
        reader.readAsDataURL(file);
        reader.onload = function () {
            resolve(reader.result);
        }
    });

async function show_file_preview_using_file_reader(e) {
    alert("abc");

    let file_element = e.target;
    let files = e.target.files;
    let object_url = null, div = null, reader = null, extension = null;

    image_template.innerHTML = "";
    if (files.length) {
        for (let index in files) {

            if (files[index] instanceof File) {

                extension = get_extenstion(files[index]);

                object_url = (icons_url[extension]) ? icons_url[extension] : await file_promise(files[index]);

                div = document.createElement('DIV');
                div.innerHTML = `
                                <img src="${object_url}" class="img-small" >
                            `;
                image_template.appendChild(div);
            }
        }

    }
}


async function show_file(e) {

    let file_element = e.target;
    let files = e.target.files;
    let object_url = null, div = null, reader = null, extension = null;

    image_templateBirthday.innerHTML = "";
    if (files.length) {
        for (let index in files) {

            if (files[index] instanceof File) {

                extension = get_extenstion(files[index]);

                object_url = (icons_url[extension]) ? icons_url[extension] : await file_promise(files[index]);

                div = document.createElement('DIV');
                div.innerHTML = `
                                <img src="${object_url}" class="img-small" >
                            `;
                image_templateBirthday.appendChild(div);
            }
        }

    }
}


async function show_file_preview(e) {

    let file_element = e.target;
    let files = e.target.files;
    let object_url = null, div = null, reader = null, extension = null;

    image_templateEducation.innerHTML = "";
    if (files.length) {
        for (let index in files) {

            if (files[index] instanceof File) {

                extension = get_extenstion(files[index]);

                object_url = (icons_url[extension]) ? icons_url[extension] : await file_promise(files[index]);

                div = document.createElement('DIV');
                div.innerHTML = `
                                <img src="${object_url}" class="img-small" >
                            `;
                image_templateEducation.appendChild(div);
            }
        }

    }
}


async function show_file_preview_agreement(e) {

    let file_element = e.target;
    let files = e.target.files;
    let object_url = null, div = null, reader = null, extension = null;

    image_templateAgreement.innerHTML = "";
    if (files.length) {
        for (let index in files) {

            if (files[index] instanceof File) {

                extension = get_extenstion(files[index]);

                object_url = (icons_url[extension]) ? icons_url[extension] : await file_promise(files[index]);

                div = document.createElement('DIV');
                div.innerHTML = `
                                <img src="${object_url}" class="img-small" >
                            `;
                image_templateAgreement.appendChild(div);
            }
        }

    }

}


async function show_file_preview_using(e) {

    let file_element = e.target;
    let files = e.target.files;
    let object_url = null, div = null, reader = null, extension = null;

    image_templateOthers.innerHTML = "";
    if (files.length) {
        for (let index in files) {

            if (files[index] instanceof File) {

                extension = get_extenstion(files[index]);

                object_url = (icons_url[extension]) ? icons_url[extension] : await file_promise(files[index]);

                div = document.createElement('DIV');
                div.innerHTML = `
                                <img src="${object_url}" class="img-small" >
                            `;
                image_templateOthers.appendChild(div);
            }
        }

    }
}