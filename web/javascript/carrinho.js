document.addEventListener('DOMContentLoaded', () => {
    const carModal = document.getElementById('carModal');
    const carTitle = document.getElementById('carTitle');
    const carDescription = document.getElementById('carDescription');
    const carSpecs = document.getElementById('carSpecs');
    const closeModal = document.querySelector('.close');
    const addToCartButton = document.getElementById('addToCartButton');

    const openModal = (carInfo) => {
        carTitle.textContent = carInfo.model;
        carDescription.textContent = carInfo.description;
        carSpecs.innerHTML = '';
        
        carInfo.specs.forEach(spec => {
            const listItem = document.createElement('li');
            listItem.textContent = spec;
            carSpecs.appendChild(listItem);
        });
        carModal.style.display = 'block';
        
                // Atualiza o evento onclick do botão "Adicionar ao Carrinho" com o ID correto
        addToCartButton.onclick = function () {
            adicionarCarrinho(carInfo.id); // Passa o ID correto do veículo
        };
    };
    

    const wantButtons = document.querySelectorAll('.want-button');
    wantButtons.forEach(button => {
        button.addEventListener('click', () => {
            const carModel = button.getAttribute('data-car-model');
            const carId = button.getAttribute('data-car-id'); // Captura o ID do carro
            let carInfo;

            // Adicione um ID único para cada carro
switch (carModel) {
    case 'Audi Supra TT':
        carInfo = {
            id: carId,
            model: 'Audi Supra TT',
            description: 'Carro esportivo de alta performance.',
            specs: ['Motor V6', '0-100 em 4s', 'Velocidade m\u00E1xima: 250 km/h']
        };
        break;
    case 'BMW X5':
        carInfo = {
            id: carId,
            model: 'BMW X5',
            description: 'SUV de luxo com design robusto.',
            specs: ['Motor V8', 'Conforto inigual\u00E1vel', 'Tecnologia de ponta']
        };
        break;
    case 'Mercedes-Benz C-Class':
        carInfo = {
            id: carId,
            model: 'Mercedes-Benz C-Class',
            description: 'Um sed\u00E3 que combina eleg\u00E2ncia e pot\u00EAncia.',
            specs: ['Motor Turbo', 'Consumo: 12 km/l', 'Conectividade Bluetooth']
        };
        break;
    case 'Toyota Corolla':
        carInfo = {
            id: carId,
            model: 'Toyota Corolla',
            description: 'Carro popular com economia de combust\u00EDvel.',
            specs: ['Motor 1.8L', 'Consumo: 14 km/l', 'Conforto e seguran\u00E7a']
        };
        break;
    case 'Ford Mustang':
        carInfo = {
            id: carId,
            model: 'Ford Mustang',
            description: 'Carro esportivo ic\u00F4nico e potente.',
            specs: ['Motor V8', '0-100 em 4s', 'Velocidade m\u00E1xima: 250 km/h']
        };
        break;
    case 'Chevrolet Tracker':
        carInfo = {
            id: carId,
            model: 'Chevrolet Tracker',
            description: 'SUV compacto com design moderno.',
            specs: ['Motor Turbo', 'Consumo: 13 km/l', 'Conectividade total']
        };
        break;
    case 'Honda Civic':
        carInfo = {
            id: carId,
            model: 'Honda Civic',
            description: 'Sed\u00E3 com alta durabilidade e economia.',
            specs: ['Motor 2.0L', 'Consumo: 12 km/l', 'Tecnologia de seguran\u00E7a']
        };
        break;
    case 'Nissan Kicks':
        carInfo = {
            id: carId,
            model: 'Nissan Kicks',
            description: 'SUV compacto e econ\u00F4mico.',
            specs: ['Motor 1.6L', 'Consumo: 14 km/l', 'Conforto e conectividade']
        };
        break;
    case 'Jeep Compass':
        carInfo = {
            id: carId,
            model: 'Jeep Compass',
            description: 'SUV com alta performance e design robusto.',
            specs: ['Motor Turbo', 'Tecnologia 4x4', 'Seguran\u00E7a avan\u00E7ada']
        };
        break;
    case 'Volkswagen Gol':
        carInfo = {
            id: carId,
            model: 'Volkswagen Gol',
            description: 'Carro popular com alto custo-benef\u00EDcio.',
            specs: ['Motor 1.0L', 'Consumo: 15 km/l', 'Compacto e econ\u00F4mico']
        };
        break;
    case 'Fiat Argo':
        carInfo = {
            id: carId,
            model: 'Fiat Argo',
            description: 'Hatch moderno com design arrojado.',
            specs: ['Motor 1.3L', 'Consumo: 12 km/l', 'Tecnologia e conforto']
        };
        break;
    case 'Hyundai Creta':
        carInfo = {
            id: carId,
            model: 'Hyundai Creta',
            description: 'SUV com conforto e seguran\u00E7a.',
            specs: ['Motor 2.0L', 'Consumo: 11 km/l', 'Tecnologia avan\u00E7ada']
        };
        break;
    default:
        carInfo = {
            id: 0,
            model: 'Modelo Desconhecido',
            description: 'Sem descri\u00E7\u00E3o dispon\u00EDvel.',
            specs: []
        };
        break;
}


            openModal(carInfo);
        });
    });

    closeModal.addEventListener('click', () => {
        carModal.style.display = 'none';
    });

    window.addEventListener('click', (event) => {
        if (event.target === carModal) {
            carModal.style.display = 'none';
        }
    });

    addToCartButton.addEventListener('click', () => {
        // Coleta as informações do carro atualmente aberto no modal
    const carInfo = {
        id: wantButtons.find(button => button.getAttribute('data-car-model') === carTitle.textContent)?.getAttribute('data-car-id'), // Captura o ID do carro baseado no título
        model: carTitle.textContent,
        description: carDescription.textContent,
        specs: Array.from(carSpecs.querySelectorAll('li')).map(li => li.textContent)
    };

    // Converte o ID para número, se necessário
    carInfo.id = Number(carInfo.id);
        const cartItems = JSON.parse(localStorage.getItem('cartItems')) || [];

        // Verifica se o carro já está no carrinho
        const existingCarIndex = cartItems.findIndex(item => item.id == carInfo.id);

        if (existingCarIndex === -1) {
            // Se não estiver no carrinho, adicione-o
            cartItems.push(carInfo);
            localStorage.setItem('cartItems', JSON.stringify(cartItems));
            alert(`${carInfo.model} foi adicionado ao carrinho!`);
        } else {
            alert(`${carInfo.model} já está no carrinho!`);
        }
    });
});
