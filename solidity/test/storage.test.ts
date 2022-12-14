import fs from 'fs';
import { ethers } from 'hardhat';
import { BigNumber } from 'ethers';

// eslint-disable-next-line node/no-missing-import
import { loadFile, loadLayers } from '../test/components/banny';

describe('Banny Asset Storage Tests', () => {
  let storage: any;
  let deployer: any;
  // eslint-disable-next-line no-unused-vars
  let accounts: any[];
  let cumulativeGas = BigNumber.from(0);

  before(() => {
    if (!fs.existsSync('test-output')) {
      fs.mkdirSync('test-output');
    }
  });

  before(async () => {
    [deployer, ...accounts] = await ethers.getSigners();

    const storageFactory = await ethers.getContractFactory('Storage');
    storage = await storageFactory.connect(deployer).deploy(deployer.address);
    await storage.deployed();
  });

  it('Load PNG assets', async () => {
    const gas = await loadLayers(storage, deployer);
    console.log(`total gas: ${gas.toString()}`);
    cumulativeGas = cumulativeGas.add(gas);
  });

  it('Load font assets', async () => {
    const gas = await loadFile(
      storage,
      deployer,
      ['..', '..', '..', 'fonts', 'Pixel Font-7-on-chain.woff'],
      '9223372036854775809',
    );
    console.log(`total gas: ${gas.toString()}`);
    cumulativeGas = cumulativeGas.add(gas);
  });

  it('Load audio assets', async () => {
    const gas = await loadFile(
      storage,
      deployer,
      ['..', '..', '..', 'audio', 'roll15.mp3'],
      '9223372036854775810',
    );
    console.log(`total gas: ${gas.toString()}`);
    cumulativeGas = cumulativeGas.add(gas);
  });

  it('Cumulative Gas', async () => {
    console.log(`cumulative gas ${cumulativeGas.toString()}`);
  });
});
